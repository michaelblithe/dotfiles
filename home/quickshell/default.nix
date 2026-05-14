{pkgs, config, ...}:

{
  programs.quickshell = {
    enable = true;
    configs.main = ./config;
    activeConfig = "main";
  };
}