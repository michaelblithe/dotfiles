{ pkgs, lib, ... }:

{
  networking.hostName = "framework";
  imports = [
    ../common
    ./disko.nix

  ];

  # Hardware support
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];

  # Graphics and Vulkan
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
    ];
  };

  # Allow Vulkan to allocate up to 60GB of system RAM for iGPU
  environment.variables.MESA_VK_DEVICE_MAX_MEMORY_PERCENT = "95";

  # Ambient light sensor for auto-brightness
  hardware.sensor.iio.enable = true;

  # Network Manager with WiFi optimizations
  networking.networkmanager = {
    enable = true;
    wifi.scanRandMacAddress = true;
  };

  # Bluetooth with power saving
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.General.Experimental = true;
  };

  # Boot configuration
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 1;

    # Framework-specific kernel parameters
    kernelParams = [
      "mem_sleep_default=deep"
      "nvme.noacpi=1"
      "intel_pstate=active"
    ];

    # Latest kernel for best Framework support
    kernelPackages = pkgs.linuxPackages_latest;

    # Plymouth boot splash
    plymouth.enable = true;
  };

  # Power management with TLP (disable conflicting services)
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # Battery health preservation
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # Aggressive power saving
      WIFI_PWR_ON_BAT = "on";
      SOUND_POWER_SAVE_ON_BAT = 1;
    };
  };

  # Thermal management
  services.thermald.enable = true;

  # SSD optimization
  services.fstrim.enable = true;

  # zram swap for better performance
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # Auto-suspend USB devices
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"
  '';

  # Firmware updates
  services.fwupd.enable = true;

  # Audio with PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 512;
        "default.clock.min-quantum" = 512;
      };
    };
  };

  # Font rendering for HiDPI
  fonts.fontconfig = {
    antialias = true;
    hinting.enable = true;
    hinting.style = "slight";
    subpixel.rgba = "rgb";
  };

  # Trackpad feel
  services.libinput = {
    enable = true;
    touchpad = {
      accelProfile = "adaptive";
      naturalScrolling = true;
      tapping = true;
    };
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

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Framework-specific packages
  environment.systemPackages = with pkgs; [
    powertop
    s-tui
    acpi
    nvme-cli
    lm_sensors
    bluetuith # Bluetooth TUI
  ];

  home-manager.users.alex.home.stateVersion = "25.11";
  system.stateVersion = "25.11";

  services.ai-open-webui.enable = true;
}
