{ pkgs, ... }:

{
  system.stateVersion = 6;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.michaelblithe = {
    home = "/Users/michaelblithe";
  };

  home-manager.users.michaelblithe.home.stateVersion = "25.11";

  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

}
