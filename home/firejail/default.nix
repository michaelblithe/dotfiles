{
  config,
  inputs,
  pkgs,
  ...
}:

{
  programs.firejail = {
    enable = true;
  };
}
