{ pkgs, lib, ...}:

{
  networking.hostName = "luna";
  imports = [
    ../common
    ./disko.nix
    ../../modules/openssh
    ../../modules/tailscale
    ../../modules/containerization
    ../../modules/desktop
  ];

  boot.initrd.availableKernelModules = [ "usb_storage" "uas" "sd_mod" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  # Desktop is available but GDM doesn't auto-start (boot to TTY)
  systemd.services.display-manager.wantedBy = lib.mkForce [];

  # GPU acceleration
  hardware.graphics.enable = true;

  # Audio (PipeWire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # XDG portal for file pickers, screen sharing, etc.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [
      "hyprland"
      "gtk"
    ];
  };

  home-manager.users.alex.home.stateVersion = "25.11";
  system.stateVersion = "25.11";

  environment.systemPackages = with pkgs; [
    kitty.terminfo
  ];

}