{ config, pkgs, ... }:

{
  dconf.settings = {
    # Enable fractional scaling
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };

    # Dark mode, scaling, and battery percentage
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
    };

    # Power settings - power saver profile
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "suspend";
      power-saver-profile-on-low-battery = true;
    };
  };
}