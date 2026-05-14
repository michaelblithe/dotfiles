{ config, pkgs, ... }:

{
  xdg.configFile = {
    "opencode/opencode.json".source = ./opencode.json;
    "opencode/skills".source = ./skills;
    "opencode/plugins".source = ./plugins;
  };
}
