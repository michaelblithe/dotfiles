{ pkgs, lib, ...}:

{
  networking.hostName = "thinkpad";
  imports = [
    ../common
    
  ];
  system.stateVersion = "25.11";
}
