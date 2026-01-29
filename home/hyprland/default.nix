{
  pkgs,
  lib,
  hostname ? "",
  ...
}:

{
  home.packages = with pkgs; [
    brightnessctl
    pamixer
    grimblast
    hyprpicker
    wlsunset
    wl-clipboard
    cliphist
    lxqt.lxqt-policykit
    networkmanagerapplet
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
      "$mod" = "SUPER";

      # Animations for smooth, responsive feel
      animations = {
        enabled = true;
        bezier = [
          "smooth, 0.25, 0.1, 0.25, 1"
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
        ];
        animation = [
          "windows, 1, 4, smooth, slide"
          "windowsOut, 1, 4, smoothOut, slide"
          "windowsMove, 1, 4, smooth"
          "fade, 1, 4, smooth"
          "workspaces, 1, 4, smooth, slide"
          "border, 1, 6, smooth"
        ];
      };

      # Visual polish - gaps, borders, rounding
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgba(ffffffee)";
        "col.inactive_border" = "rgba(59595966)";
        layout = "dwindle";
      };

      # Window decorations - blur, shadows, rounding
      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 8;
          passes = 2;
          new_optimizations = true;
          xray = false;
        };
        shadow = {
          enabled = true;
          range = 12;
          render_power = 3;
          color = "rgba(00000055)";
        };
      };

      # Misc quality-of-life
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        vfr = true;
      };

      # Dwindle layout settings
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      monitor =
        if hostname == "framework" then [
          ",preferred,auto,1.33"
          "eDP-1,2256x1504@60,0x0,1.33"
        ] else if hostname == "house-of-wind" then [
          "DP-7,3440x1440@120,0x0,1"
          "DP-4,1920x1080@60,3440x0,1,transform,1"
        ] else [
          ",preferred,auto,1"
        ];

      exec-once = [
        "waybar"
        "hypridle"
        "protonvpn-gui"
        # Clipboard manager
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        # Polkit authentication agent
        "lxqt-policykit-agent"
        "sleep 3 && nm-applet"
      ] ++ lib.optionals (hostname == "framework") [
        "wlsunset -l 40.7 -L -74.0"
      ];

      input = lib.mkIf (hostname == "framework") {
        touchpad = {
          natural_scroll = false;
          disable_while_typing = true;
          clickfinger_behavior = true;
          tap-to-click = true;
          drag_lock = true;
        };

        kb_options = "caps:escape";
        repeat_rate = 50;
        repeat_delay = 250;
      };

      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod, D, exec, rofi -show drun"
        "$mod SHIFT, Q, killactive,"
        "$mod, F, fullscreen,"
        "$mod, T, togglefloating,"
        "$mod, M, exit,"
        # Move focus between windows
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        # Switch to workspaces 1-8
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        # Move focused window to workspaces 1-8
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        # Setup brightness keys
        ",XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        # Setup volume keys
        ",XF86AudioRaiseVolume, exec, pamixer --increase 5"
        ",XF86AudioLowerVolume, exec, pamixer --decrease 5"
        ",XF86AudioMute, exec, pamixer --toggle-mute"
        # Lock screen
        "$mod CTRL, L, exec, hyprlock"
        # Power management
        ",XF86PowerOff, exec, systemctl suspend"
        "$mod SHIFT, L, exec, systemctl suspend"
        # Screenshot with grimblast
        "$mod SHIFT, S, exec, grimblast copy area"
        # Color picker
        "$mod, P, exec, hyprpicker -a"
        # Clipboard history
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = true;
      };

      background = {
        monitor = "";
        path = "";
        color = "rgba(25, 20, 20, 1.0)";
      };

      input-field = {
        monitor = "";
        size = "200, 50";
        outline_thickness = 3;
        dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "rgb(151515)";
        inner_color = "rgb(200, 200, 200)";
        font_color = "rgb(10, 10, 10)";
        fade_on_empty = true;
        placeholder_text = "<i>Input Password...</i>";
        hide_input = false;
        position = "0, -20";
        halign = "center";
        valign = "center";
      };

      label = {
        monitor = "";
        text = "$TIME";
        color = "rgba(200, 200, 200, 1.0)";
        font_size = 64;
        font_family = "Noto Sans";
        position = "0, 80";
        halign = "center";
        valign = "center";
      };
    };
  };

  # Notification daemon
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    borderRadius = 8;
    borderSize = 2;
    padding = "12";
    margin = "12";
    backgroundColor = "#191919ee";
    textColor = "#ffffff";
    borderColor = "#ffffff33";
    layer = "overlay";
    font = "JetBrainsMono 11";
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on "; # to avoid having to press a key twice to turn on the display.
      };

      listener = [
        {
          timeout = 300; # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }
        {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r"; # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 1800; # 30min
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };
}
