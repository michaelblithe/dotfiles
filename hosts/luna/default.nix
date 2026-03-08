{ pkgs, lib, ...}:

{
  networking.hostName = "luna";
  imports = [
    ../common
    ./disko.nix
    ../../modules/openssh
    ../../modules/tailscale
  ];

  boot.initrd.availableKernelModules = [ "usb_storage" "uas" "sd_mod" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  home-manager.users.alex.home.stateVersion = "25.11";
  system.stateVersion = "25.11";

  environment.systemPackages = with pkgs; [
    kitty.terminfo
  ];
  
}