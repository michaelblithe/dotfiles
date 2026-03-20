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
    catppuccin.homeModules.catppuccin
  ];
}
