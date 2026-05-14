{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # LazyVim and plugins will be managed by lazy.nvim at runtime
    # We just need to provide neovim and basic dependencies
    extraPackages = with pkgs; [
      # LSP servers
      lua-language-server
      nil # Nix LSP
      pyright
      typescript-language-server
      gopls

      # tree sitter
      gcc

      # Formatters
      stylua
      nixfmt
      isort

      # Tools for telescope and other plugins
      ripgrep
      fd
      git
      lazygit

      # Mason dependencies
      nodejs
      python3
      unzip

    ]
    ++ lib.optionals (pkgs.stdenv.isLinux) [
      # Clipboard support
      wl-clipboard
      xclip
    ];
  };

  # Copy nvim configuration files to ~/.config/nvim
  # vim.pack manages plugins at runtime under ~/.local/share/nvim/site/pack
  xdg.configFile = {
    "nvim/init.lua".source = ../../nvim/init.lua;
    "nvim/lua".source = ../../nvim/lua;
  };

  # Ensure the nvim data directory exists for lazy.nvim
  home.activation.createNvimDirs = ''
    mkdir -p ${config.home.homeDirectory}/.local/share/nvim
    mkdir -p ${config.home.homeDirectory}/.config/nvim
  '';
}
