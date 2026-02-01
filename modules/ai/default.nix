{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.ai-llama-server;
in
{
  options.services.ai-llama-server = {
    enable = mkEnableOption "llama-server AI inference service";

    host = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "IP address to bind to";
    };

    port = mkOption {
      type = types.port;
      default = 8001;
      description = "Port to listen on";
    };

    parallel = mkOption {
      type = types.int;
      default = 1;
      description = "Number of parallel request slots";
    };

    modelPresetFile = mkOption {
      type = types.path;
      description = "Path to the model preset INI file";
    };

    package = mkOption {
      type = types.package;
      default = pkgs.llama-cpp;
      defaultText = literalExpression "pkgs.llama-cpp";
      description = "The llama-cpp package to use";
    };
  };

  config = mkIf cfg.enable {
    # Sops secret for llama-cpp API key
    sops.secrets.llama-cpp = {
      sopsFile = ../../secrets/ai.yaml;
    };

    # Deploy model preset file to /etc/llama-server/models.ini
    environment.etc."llama-server/models.ini".source = cfg.modelPresetFile;

    # System user for the service
    users.users.llama-server = {
      isSystemUser = true;
      group = "llama-server";
      description = "llama-server service user";
    };
    users.groups.llama-server = {};

    # Systemd service
    systemd.services.llama-server = {
      description = "llama.cpp inference server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        Type = "exec";
        User = "llama-server";
        Group = "llama-server";
        SupplementaryGroups = [ "video" "render" ];
        Restart = "always";
        RestartSec = "5s";
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        NoNewPrivileges = true;
        ReadWritePaths = [ "/var/lib/llama-server" ];
      };

      script = ''
        export LLAMA_ARG_API_KEY=$(cat ${config.sops.secrets.llama-cpp.path})
        exec ${cfg.package}/bin/llama-server \
          --host ${cfg.host} \
          --port ${toString cfg.port} \
          --parallel ${toString cfg.parallel} \
          --models-preset /etc/llama-server/models.ini
      '';
    };

    # State directory for model cache
    systemd.tmpfiles.rules = [
      "d /var/lib/llama-server 0755 llama-server llama-server -"
    ];
  };
}
