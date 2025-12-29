{ pkgs, ...}:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/New_York";

  users.users.root = {
    password = "changeme";
  };

  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager"];
    # Use an initial plaintext password for first boot; change it after logging in.
    password = "changeme";
  };

}