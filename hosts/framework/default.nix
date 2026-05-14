{ pkgs, lib, ...}:

{
  networking.hostName = "framework";
  imports = [
    ../common
    ./disko.nix
    
  ];
  home-manager.users.alex.home.stateVersion = "25.11";
        virtualisation.vmVariant = {
          virtualisation = {
            memorySize = 8192; # in MB
            cores = 8;
            graphics = true;
          };
        };
  system.stateVersion = "25.11";
}
