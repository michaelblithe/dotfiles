{ config, pkgs, lib, catppuccin, ... }:

{
  imports = [
    ../git
    ../zsh
    ../nvim
    ../direnv
    ../opencode
    ../claude-code
    ../syncthing
    ../gnome
    ../hyprland
    ../kitty
    ../fonts
    ../rofi
    ../waybar
    catppuccin.homeModules.catppuccin
  ];

  # Override gnome power settings — never sleep
  dconf.settings."org/gnome/settings-daemon/plugins/power" = {
    sleep-inactive-battery-type = lib.mkForce "nothing";
  };
}
