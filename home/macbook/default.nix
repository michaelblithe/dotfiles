{ config, pkgs, catppuccin, ... }:

{
  imports = [
    ../git
    ../zsh
    ../nvim
    ../direnv
    # ../kitty
    # ../fonts
    # ../vscode
    ../opencode
    # ../claude-code
    ../helix
    ../zathura
    ../tmux
    ../qute-browser
    catppuccin.homeModules.catppuccin
  ];
}
