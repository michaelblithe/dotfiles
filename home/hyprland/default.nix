{
  config,
  inputs,
  pkgs,
  lib,
  hostname ? "",
  ...
}:

{
  home.packages = with pkgs; [
    brightnessctl
    pamixer
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
      "$mod" = "SUPER";

      monitor = lib.mkIf (hostname == "framework") [
        ",preferred,auto,1.33"
      ];

      exec-once = [
        "waybar"
        "hypridle"
        "protonvpn-gui"
      ];

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
        "$mod, L, exec, hyprlock"
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
