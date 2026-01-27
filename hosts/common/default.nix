{ pkgs, inputs, ...}:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/New_York";

  users.users.root = {
    initialPassword = "changeme";
  };


  # Needed for proton VPN to work properly
  networking.firewall.checkReversePath = false;

  sops.age.keyFile = "/home/alex/.config/sops/age/keys.txt";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "podman" "docker" ];
    shell = pkgs.zsh;
    # Use an initial plaintext password for first boot; change it after logging in.
    initialPassword = "changeme";
  };

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "suspend";
    lidSwitchExternalPower = "suspend";
  };

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.hardware.bolt.enable = true;

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  virtualisation.podman.enable = true;
  # virtualisation.podman.dockerCompat = true;
  virtualisation.containers.registries.search = [ "docker.io" ];
  environment.sessionVariables = {
    # Force docker-compose to use the CLI build flow (invoking podman)
    # instead of trying to talk to a Docker daemon API directly.
    COMPOSE_DOCKER_CLI_BUILD = "1";

    # Prevent the "classic builder" error by signaling BuildKit support
    DOCKER_BUILDKIT = "1";
  };
  virtualisation.docker.enable = true;

  imports = [
    ../../modules/firejail
    ../../modules/wireguard
  ];

  environment.systemPackages = (with pkgs; [
    vim
    git
    wget
    curl
    networkmanager
    neofetch
    htop
    podman
    podman-compose
    docker-compose
    vscode
    neovim
    gh
    nixfmt
    nil
    spotify
    protonvpn-gui
    wireguard-tools
    age
    sops
    clamav
    impala
    bluetui
    fastfetch
    btop
    lazydocker
    opencode
    lftp
    unzip
    python3
    discordo
  ]) ++ [
    unstable.lmstudio
    unstable.claude-code
  ];

}
