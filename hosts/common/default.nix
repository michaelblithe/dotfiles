{ pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  time.timeZone = "America/New_York";

  users.users.root = {
    initialPassword = "changeme";
  };

  sops.age.keyFile = "/home/alex/.config/sops/age/keys.txt";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "podman"
      "docker"
    ];
    shell = pkgs.zsh;
    # Use an initial plaintext password for first boot; change it after logging in.
    initialPassword = "changeme";
  };

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  imports = [
    ../../modules/firejail
  ];

  environment.systemPackages =
    (with pkgs; [
      git
      wget
      curl
      networkmanager
      fastfetch
      htop
      age
      sops
      clamav
      impala
      bluetui
      fastfetch
      btop
      lazydocker
      lftp
      unzip
      python3
    ]);
}
