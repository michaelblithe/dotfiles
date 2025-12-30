{ config, pkgs, ... }:

{
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "lambda";
        plugins = ["git"];
      };
    };
}