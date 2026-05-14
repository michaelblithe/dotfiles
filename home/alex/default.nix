{ config, pkgs, ... }:

{
  imports = [ 
    ../vscode
    ../gnome
    ../zsh
    ../firefox
    ../git
  ];
}
