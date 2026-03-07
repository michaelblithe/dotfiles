{ config, pkgs, ... }:

{
  imports = [
    ../git
    ../zsh
    ../nvim
    ../direnv
    ../opencode
    ../claude-code
  ];
}
