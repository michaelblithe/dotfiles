{ config, pkgs, lib, catppuccin, ... }:

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
    ../syncthing
    ../chrome
    ../direnv
    ../discord
    ../calibre
    ../opencode
    ../claude-code
    ../zathura
    ../tmux
    ../spotify
    ../lmstudio
    catppuccin.homeModules.catppuccin
  ];

  # Override gnome power settings — never sleep
  dconf.settings."org/gnome/settings-daemon/plugins/power" = {
    sleep-inactive-battery-type = lib.mkForce "nothing";
  };
}
