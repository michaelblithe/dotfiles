{ config, pkgs, ... }:

{
  sops = {
    age.keyFile = "/home/alex/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/syncthing.yaml;
    secrets.framework_device_id = {};
    secrets.macbook_device_id = {};
  };
  
  services.syncthing = {
    enable = true;

    settings = {
      devices = {
        "framework" = { id = config.sops.secrets.framework_device_id.path; };
        "macbook" = { id = config.sops.secrets.macbook_device_id.path; };
        # "luna" = { };
        # "desktop" = { };
      };
      folders = {
        "notes" = {
          path = "/home/alex/notes";
          devices = [ "framework" "macbook" ];
        };
        "games" = {
          path = "/home/alex/games";
          devices = [ "framework" "macbook" ];
        };
      };
    };
  };
}
