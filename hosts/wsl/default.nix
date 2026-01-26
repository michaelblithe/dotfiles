{ config, pkgs, ... }:
{
  wsl.enable = true;
  wsl.defaultUser = "alex";

  networking.hostName = "wsl";

  time.timeZone = "America/New_York";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
