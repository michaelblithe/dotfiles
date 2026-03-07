{ config, pkgs, ... }:

{
  imports = [
    ../git
    ../nvim
    ../direnv
    ../kitty
    ../fonts
    ../vscode
    ../opencode
    ../claude-code
  ];
}
