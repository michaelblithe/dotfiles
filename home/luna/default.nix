{ config, pkgs, catppuccin, ... }:

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
}
