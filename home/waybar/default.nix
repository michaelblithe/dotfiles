{
  config,
  pkgs,
  catppuccin,
  ...
}:

{
  catppuccin.waybar = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
    mode = "prependImport";
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        height = 34;
        position = "top";

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "battery"
          "pulseaudio"
          "network"
          "idle_inhibitor"
        ];

        # Module configurations
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{name}";
        };

        "hyprland/window" = {
          separate-outputs = true;
          max-length = 80;
        };

        pulseaudio = {
          format = "{volume}% 🔊";
          format-muted = "muted 🔇";
          scroll-step = 5;
          on-click = "pavucontrol";
        };

        network = {
          format-wifi = "{essid}";
          format-ethernet = " {ifname}";
          format-disconnected = "disconnected";

          tooltip = false;
        };

        battery = {
          format = "{icon} {percent}%";
          format-discharging = "{icon} {percent}%";
          format-charging = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "󰾪";
          };
        };

        clock = {
          interval = 1;
          timezone = "America/New_York";
          format = "{:%a %b %d %I:%M%p}";
          on-click = "hyprctl dispatch exec [float] 'gnome-calendar'";
          tooltip = true;
          tooltip-format = "{:%a %b %d %I:%M%p}";
        };
      };
    };

    # style = ''
    #   * {

    #     font-family: Pixel Operator Mono, JetBrainsMono Nerd Font, monospace;
    #     font-size: 14pt;
    #     color: #ffffff;
    #   }

    #   window#waybar {
    #     background: rgba(25,25,25,0.9);
    #     border-bottom: 1px solid rgba(255,255,255,0.08);
    #   }

    #   /* Workspaces */
    #   #workspaces {
    #     padding-left: 8px;
    #   }
    #   #workspaces button {
    #     padding: 0 8px;
    #     border-radius: 6px;
    #   }
    #   #workspaces button.active {
    #     background: rgba(255,255,255,0.12);
    #     box-shadow: inset 0 -2px 0 0 rgba(255,255,255,0.6);
    #   }

    #   #clock, #network, #pulseaudio, #idle_inhibitor {
    #     padding: 0 15px;
    #   }

    # '';
  };
}
