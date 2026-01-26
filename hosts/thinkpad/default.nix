{ pkgs, lib, ...}:

{
  networking.hostName = "thinkpad";
  imports = [
    ../common
    
  ];
  home-manager.users.alex.home.stateVersion = "25.11";
  system.stateVersion = "25.11";
}
