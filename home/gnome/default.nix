{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
  ];

  # Catppuccin Mocha GTK theme
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "catppuccin-mocha-blue-standard";
  #     package = pkgs.catppuccin-gtk.override {
  #       variant = "mocha";
  #       accents = [ "blue" ];
  #       size = "standard";
  #     };
  #   };
  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.catppuccin-papirus-folders.override {
  #       flavor = "mocha";
  #       accent = "blue";
  #     };
  #   };
  # };

  # Catppuccin Mocha cursors
  home.pointerCursor = {
    gtk.enable = true;
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 24;
  };

  dconf.settings = {

    # Shell: extensions and favorites
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
      ];
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "firefox.desktop"
        "kitty.desktop"
        "code.desktop"
      ];
    };

    # Dash to Dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      dash-max-icon-size = lib.hm.gvariant.mkInt32 48;
      click-action = "minimize";
      scroll-action = "cycle-windows";
      apply-custom-theme = false;
      transparency-mode = "DYNAMIC";
      show-trash = false;
      show-mounts = false;
      hot-keys = false;
    };

    # Mutter: fractional scaling + edge tiling
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
      edge-tiling = true;
      dynamic-workspaces = true;
      workspaces-only-on-primary = true;
    };

    # Interface: dark mode, battery, titlebar buttons, clock
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
      enable-hot-corners = false;
      clock-show-weekday = true;
      gtk-theme = "catppuccin-mocha-blue-standard";
      icon-theme = "Papirus-Dark";
      cursor-theme = "catppuccin-mocha-dark-cursors";
    };

    # Titlebar buttons + window focus
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      focus-mode = "click";
    };

    # Keybindings — window management
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      toggle-fullscreen = [ "<Super>f" ];
      minimize = [ "<Super>h" ];
      maximize = [ "<Super>Up" ];
      # Workspace navigation
      switch-to-workspace-left = [ "<Super>bracketleft" ];
      switch-to-workspace-right = [ "<Super>bracketright" ];
      move-to-workspace-left = [ "<Super><Shift>bracketleft" ];
      move-to-workspace-right = [ "<Super><Shift>bracketright" ];
    };

    # Custom keybinding: Super+Return → kitty
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      command = "kitty";
      binding = "<Super>Return";
    };

    # Super+D → overview (app launcher)
    "org/gnome/shell/keybindings" = {
      toggle-overview = [ "<Super>d" ];
    };

    # Touchpad: tap-to-click, no natural scroll
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      natural-scroll = false;
    };

    # Night Light: auto-schedule, 3500K
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
      night-light-temperature = lib.hm.gvariant.mkUint32 3500;
    };

    # Power: don't sleep on AC, 30min on battery
    "org/gnome/settings-daemon/plugins/power" = {
      power-saver-profile-on-low-battery = true;
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-battery-timeout = lib.hm.gvariant.mkInt32 1800;
    };

    # Nautilus: list view, hidden files, small zoom
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      show-hidden-files = true;
    };
    "org/gnome/nautilus/list-view" = {
      default-zoom-level = "small";
    };
  };
}
