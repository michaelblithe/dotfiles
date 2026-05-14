{ pkgs, ... }:

{
  programs.zathura = {
    enable = true;
  };

  catppuccin.zathura = {
    enable = true;
    flavor = "mocha";
  };
}
