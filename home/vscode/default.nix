{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-marketplace; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        ftsamoyed.theme-pink-cat-boo
        ms-azuretools.vscode-containers
        ms-vscode-remote.remote-containers
        openai.chatgpt
        # rooveterinaryinc.roo-cline
        saoudrizwan.claude-dev
        jnoortheen.nix-ide
        vscodevim.vim
        anthropic.claude-code
      ];
      userSettings = {
        "github.copilot.nextEditSuggestions.enabled" = true;
        "vim.useSystemClipboard" = true;
        "vim.handleKeys" = {
          "<C-p>" = false;
        };
        "workbench.colorTheme" = "Pink Cat Boo";
        "workbench.iconTheme" = "catppuccin-mocha";
        "redhat.telemetry.enabled" = false;
        "containers.containerClient" = "com.microsoft.visualstudio.containers.podman";
        "containers.orchestratorClient" = "com.microsoft.visualstudio.orchestrators.podmancompose";
        "git.autofetch" = true;
        "github.copilot.enable" = {
          "*" = true;
          "plaintext" = false;
          "markdown" = true;
          "scminput" = false;
        };
      };
    };
  };
}