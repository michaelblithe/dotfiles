{ pkgs, lib, ...}:

{
  networking.hostName = "luna";
  imports = [
    ../common
    ./disko.nix
    
  ];
  home-manager.users.alex.home.stateVersion = "25.11";
  system.stateVersion = "25.11";
}