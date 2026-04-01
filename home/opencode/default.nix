{ config, catppuccin, pkgs, ... }:

{
  catppuccin.opencode = {
    enable = false;
  };
  programs.opencode = {
    enable = true;
  };
  xdg.configFile = {
    "opencode/opencode.json".source = ./opencode.json;
    "opencode/agents".source = ./agents;
    "opencode/skills".source = ./skills;
    "opencode/plugins".source = ./plugins;
  };
}
