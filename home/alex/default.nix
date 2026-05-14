{ config, pkgs, ... }:

{
  home.sessionVariables = {
    # COMPOSE_DOCKER_CLI_BUILD = "1";
    # DOCKER_BUILDKIT = "1";
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
  ];
}
