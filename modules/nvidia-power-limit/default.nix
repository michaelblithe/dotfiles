{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.hardware.nvidia.powerLimit;
in
{
  options.hardware.nvidia.powerLimit = {
    enable = mkEnableOption "NVIDIA GPU power limiting";

    watts = mkOption {
      type = types.ints.between 70 420;
      default = 250;
      description = "Power limit in watts (70-420W range for RTX 3090)";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.nvidia-power-limit = {
      description = "Set NVIDIA GPU power limit";
      wantedBy = [ "multi-user.target" ];
      after = [ "nvidia-persistenced.service" ];
      partOf = [ "nvidia-persistenced.service" ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      path = [ config.hardware.nvidia.package ];

      script = ''
        nvidia-smi -pl ${toString cfg.watts}
      '';
    };
  };
}
