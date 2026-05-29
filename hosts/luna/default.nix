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
    ../../modules/k3s-server
  ];

  boot = {
    initrd.availableKernelModules = [ "usb_storage" "uas" "sd_mod" ];
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 10;
    loader.efi.canTouchEfiVariables = true;
    kernelParams = [ "intel_pstate=active" ];
  };

  powerManagement.cpuFreqGovernor = "performance";

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

  # Disable sleep/suspend entirely — screen off is fine
  services.logind = {
    lidSwitch = lib.mkForce "lock";
    lidSwitchDocked = lib.mkForce "lock";
    lidSwitchExternalPower = lib.mkForce "lock";
  };
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  environment.systemPackages = with pkgs; [
    kitty.terminfo
  ];

  services.k3s.serverAddr = "https://luna:6443";

}
