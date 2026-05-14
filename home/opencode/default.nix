{ config, catppuccin, pkgs, ... }:

{
  catppuccin.opencode = {
    enable = false;
  };
  programs.opencode = {
    enable = true;
    agents = {
      implementation = ./agents/implement.md;
      research = ./agents/research.md;
      search = ./agents/search.md;
      writeTests = ./agents/write-tests.md;
    };
  };
  xdg.configFile = {
    "opencode/opencode.json".source = ./opencode.json;
    "opencode/skills".source = ./skills;
  };
}
