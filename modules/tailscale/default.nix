{ config, ... }:

{
  sops.secrets.tailscale-auth-key = {
    sopsFile = ../../secrets/tail-scale.yaml;
    key = "auth-keys";
  };

  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets.tailscale-auth-key.path;
    openFirewall = true;
  };
}
