{ pkgs, lib, ...}:

{
  networking.hostName = "thinkpad";
  imports = [
    ../common
    ./disko.nix
    
  ];
        virtualisation.vmVariant = {
          virtualisation = {
            memorySize = 8192; # in MB
            cores = 8;
            graphics = true;
          };
        };
  system.stateVersion = "25.11";
}