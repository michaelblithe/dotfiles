{
  config,
  pkgs,
  catppuccin,
  ...
}:

let
  vpnScript = pkgs.writeShellScript "waybar-vpn" ''
    status=$(protonvpn-cli s 2>/dev/null)
    if echo "$status" | grep -q "Connected"; then
      server=$(echo "$status" | grep "Server:" | awk '{print $2}')
      echo '{"text":"󰌾","tooltip":"VPN: '"$server"'","class":"connected"}'
    else
      echo '{"text":"󰦞","tooltip":"VPN: Disconnected","class":"disconnected"}'
    fi
  '';
in
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
        spacing = 8;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "network"
          "custom/vpn"
          "pulseaudio"
          "idle_inhibitor"
          "battery"
        ];

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{name}";
        };

        "hyprland/window" = {
          separate-outputs = true;
          max-length = 50;
        };

        network = {
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-disconnected = "󰤭";
          tooltip = true;
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{ifname}";
          tooltip-format-disconnected = "Disconnected";
        };

        "custom/vpn" = {
          exec = "${vpnScript}";
          return-type = "json";
          interval = 10;
          format = "{}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 muted";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          scroll-step = 5;
          on-click = "pamixer -t";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "󰾪";
          };
          tooltip-format-activated = "Caffeine on";
          tooltip-format-deactivated = "Caffeine off";
        };

        battery = {
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          states = {
            warning = 20;
            critical = 10;
          };
        };

        clock = {
          interval = 1;
          timezone = "America/New_York";
          format = "{:%a %b %d %I:%M%p}";
          on-click = "hyprctl dispatch exec [float] 'gnome-calendar'";
          tooltip = true;
          tooltip-format = "{:%A, %B %d %Y}";
        };
      };
    };

    style = ''
      * {
        font-family: JetBrainsMono Nerd Font, monospace;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: alpha(@base, 0.9);
        border-bottom: 1px solid @surface0;
        color: @text;
      }

      #workspaces {
        margin-left: 8px;
      }

      #workspaces button {
        padding: 0 8px;
        color: @subtext0;
        border-radius: 6px;
        margin: 4px 2px;
      }

      #workspaces button.active {
        background: @surface0;
        color: @blue;
      }

      #workspaces button:hover {
        background: @surface1;
        color: @text;
      }

      #window {
        color: @subtext1;
        padding: 0 8px;
      }

      #clock,
      #battery,
      #pulseaudio,
      #network,
      #custom-vpn,
      #idle_inhibitor {
        padding: 0 12px;
        margin: 4px 2px;
        border-radius: 8px;
        background: @surface0;
        color: @text;
      }

      #battery.warning {
        color: @yellow;
      }

      #battery.critical {
        color: @red;
      }

      #battery.charging {
        color: @green;
      }

      #network.disconnected {
        color: @overlay0;
      }

      #custom-vpn.connected {
        color: @green;
      }

      #custom-vpn.disconnected {
        color: @overlay0;
      }

      #pulseaudio.muted {
        color: @overlay0;
      }

      #idle_inhibitor.activated {
        color: @peach;
      }
    '';
  };
}
