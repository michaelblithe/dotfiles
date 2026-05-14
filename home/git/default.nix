{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "michaelrblithe@gmail.com";
        name = "Alex Blithe";
      };
      pull.rebase = false;
    };
  };
}
