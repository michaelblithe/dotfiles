
{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "michaelrblithe@gmail.com";
    userName = "Alex Blithe";
  };
}