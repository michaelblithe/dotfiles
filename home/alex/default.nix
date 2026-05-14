{ config, pkgs, ... }:

{
  imports = [ 
    ../vscode
    ../gnome
    ../zsh
    ../firefox
    ../git
    ../kitty
    ../hyprland
    ../fonts
    ../rofi
  ];
}
