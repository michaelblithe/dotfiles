{ config, pkgs, ... }:

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
  ];
}
