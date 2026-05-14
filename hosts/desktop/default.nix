{ pkgs, ...}:

{
  networking.hostName = "house-of-wind";
  imports = [
    ../common
    ./disko.nix
  ];
  
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];
  networking.networkmanager.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  home-manager.users.alex.home.stateVersion = "25.11";
  system.stateVersion = "25.11";

  boot.kernelParams = [
    "amd_iommu=off"
    "amdgpu.gttsize=126976"
    "ttm.pages_limit=32505856"
  ];
}
