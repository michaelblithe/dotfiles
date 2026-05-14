{ config, pkgs, ... }:

{
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
          "hyprland/window"
        ];
        
        modules-right = [
          "pulseaudio"
          "network"
          "clock"
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
          format-wifi = "{essid} {signalStrength}%";
          format-ethernet = " {ifname}";
          format-disconnected = "disconnected";
          tooltip = false;
        };
        
        clock = {
          format = "{:%I:%M %p}";
          format-alt = "{:%d-%m-%Y}";
        };
      };
    };
    
    style = ''
      * {
        font-family: JetBrainsMono, monospace;
        font-size: 11pt;
        color: #ffffff;
      }

      window#waybar {
        background: rgba(25,25,25,0.9);
        border-bottom: 1px solid rgba(255,255,255,0.08);
      }


      /* Workspaces */
      #workspaces {
        padding-left: 8px;
      }
      #workspaces button {
        padding: 0 8px;
        border-radius: 6px;
      }
      #workspaces button.active {
        background: rgba(255,255,255,0.12);
        box-shadow: inset 0 -2px 0 0 rgba(255,255,255,0.6);
      }

      #clock, #network, #pulseaudio {
        padding: 0 10px;
      }
    '';
  };
}
