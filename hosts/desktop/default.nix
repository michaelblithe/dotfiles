{ pkgs, config, lib, ...}:

{
  networking.hostName = "house-of-wind";
  imports = [
    ../common
    ./disko.nix
    ../../modules/ai
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
    "amd_iommu=on"
    "iommu=pt"
    "amdgpu.gttsize=126976"
    "ttm.pages_limit=32505856"
  ];

  # Set CPU governor to performance
  powerManagement.cpuFreqGovernor = "performance";

  # GPU drivers
  # services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];

  # ROCm support for AMD GPU
  # hardware.amdgpu.opencl.enable = true;
  # hardware.amdgpu.initrd.enable = true;
  hardware.graphics.enable = true;
  # virtualisation.podman.enableNvidia = true;

  # hardware.nvidia = {
  #   # Modesetting is required
  #   modesetting.enable = true;

  #   # Use the proprietary NVIDIA drivers
  #   open = false;

  #   # Enable the NVIDIA settings menu
  #   nvidiaSettings = true;

  #   # Select the appropriate driver version
  #   # Use "production" for stable, or specify a version
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };

  # CUDA + ROCm support
  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit
    cudaPackages.cudnn
    rocmPackages.rocm-smi
    rocmPackages.clr
    llama-cpp
  ];

  services.ai-llama-server = {
    enable = true;
    modelPresetFile = ../../modules/ai/model-files/desktop.ini;
  };

}
