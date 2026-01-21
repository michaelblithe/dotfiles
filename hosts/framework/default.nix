{ pkgs, lib, ...}:

{
  networking.hostName = "framework";
  imports = [
    ../common
    ./disko.nix
    
  ];
  
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];
  networking.networkmanager.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  home-manager.users.alex.home.stateVersion = "25.11";
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192; # in MB
      cores = 8;
      graphics = true;
    };
  };
  system.stateVersion = "25.11";

    powerManagement.cpuFreqGovernor = "powersave";
}
