{ pkgs, inputs, ...}:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/New_York";

  users.users.root = {
    initialPassword = "changeme";
  };

  # Needed for proton VPN to work properly
  networking.firewall.checkReversePath = false;

  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager"];
    shell = pkgs.zsh;
    # Use an initial plaintext password for first boot; change it after logging in.
    initialPassword = "changeme";
  };

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.hardware.bolt.enable = true;

  programs.zsh.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  imports = [
    ../../modules/firejail
  ];

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    networkmanager
    neofetch
    htop
    podman
    vscode
    neovim
    gh
    nixfmt
    nil
    spotify
    claude-code
    protonvpn-gui
    wireguard-tools
  ];

}