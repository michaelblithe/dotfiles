{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    
    profiles.default = {
      id = 0;
      isDefault = true;
      
      # Install extensions
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
      ];
      
      # Firefox settings
      settings = {
        # Enable dark mode
        "ui.systemUsesDarkTheme" = 1;
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
      };
    };
  };
}
