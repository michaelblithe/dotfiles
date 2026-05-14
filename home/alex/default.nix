{ config, pkgs, catppuccin, ... }:

{
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };
  imports = [
    ../vscode
    ../gnome
    ../zsh
    ../firefox
    ../git
    ../kitty
    ../nvim
    ../hyprland
    ../fonts
    ../rofi
    ../waybar
    ../emu
    ../syncthing
    ../chrome
    ../direnv
    ../discord
    ../calibre  
    ../opencode
    # ../claude-code
    ../zathura
    ../tmux
    ../spotify
    ../lmstudio
    catppuccin.homeModules.catppuccin
  ];
}
