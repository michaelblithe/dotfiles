{ pkgs, config, lib, ...}:

{
  networking.hostName = "house-of-wind";
  imports = [
    ../common
    ./disko.nix
    ../../modules/ai/llama-cpp.nix
    ../../modules/containerization
    ../../modules/desktop
    ../../modules/openssh
    ../../modules/tailscale
  ];
  
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];
  networking.networkmanager.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  home-manager.users.alex.home.stateVersion = "25.11";
  system.stateVersion = "25.11";

  # Make GPU have enough VRAM
  boot.initrd.kernelModules = [ "thunderbolt" ];

  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
    "amdgpu.gttsize=126976"
    "ttm.pages_limit=32505856"
  ];

  # Set CPU governor to performance
  powerManagement.cpuFreqGovernor = "performance";

  # GPU drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  # ROCm support for AMD GPU
  # hardware.amdgpu.opencl.enable = true;
  # hardware.amdgpu.initrd.enable = true;
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

  # CUDA + ROCm support
  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit
    cudaPackages.cudnn
    rocmPackages.rocm-smi
    rocmPackages.clr
    llama-cpp
  ];

  # Allow Open WebUI (port 3000) on Tailscale only
  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 3000 ];

  services.openssh.enable = true;

  services.ai-llama-server = {
    enable = true;
    host = "0.0.0.0";
    modelPresetFile = ../../modules/ai/model-files/desktop.ini;
  };

}
