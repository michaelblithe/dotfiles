{ pkgs, config, ...}:

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

  # Make GPU have enough VRAM
  boot.kernelParams = [
    "amd_iommu=off"
    "amdgpu.gttsize=126976"
    "ttm.pages_limit=32505856"
  ];

  # Set CPU governor to performance
  powerManagement.cpuFreqGovernor = "performance";

  # NVIDIA proprietary drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  virtualisation.podman.enableNvidia = true;

  hardware.nvidia = {
    # Modesetting is required
    modesetting.enable = true;

    # Use the proprietary NVIDIA drivers
    open = false;

    # Enable the NVIDIA settings menu
    nvidiaSettings = true;

    # Select the appropriate driver version
    # Use "production" for stable, or specify a version
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # CUDA support
  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit
    cudaPackages.cudnn
    llama-cpp
  ];
}
