{ config, pkgs, ... }:

{
  home.packages = [ pkgs.nixpkgs-fmt ];

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
        rooveterinaryinc.roo-cline
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
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {
              "command" = [ "nixpkgs-fmt" ];
            };
          };
        };
        "workbench.colorTheme" = "Pink Cat Boo";
        "workbench.iconTheme" = "catppuccin-mocha";
        "redhat.telemetry.enabled" = false;
        "containers.containerClient" = "com.microsoft.visualstudio.containers.podman";
        "containers.orchestratorClient" = "com.microsoft.visualstudio.orchestrators.podmancompose";
        #"remote.containers.dockerPath" = pkgs.podman + "/bin/podman";
        "editor.fontFamily" = "'Droid Sans Mono', 'monospace', monospace";
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
