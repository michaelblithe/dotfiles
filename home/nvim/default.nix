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
      rust-analyzer
      gopls
      
      # Formatters
      stylua
      nixpkgs-fmt
      black
      isort
      prettier
      
      # Tools for telescope and other plugins
      ripgrep
      fd
      git
      
      # Clipboard support
      wl-clipboard
      xclip
    ];
  };

  # Copy nvim configuration files to ~/.config/nvim
  # We use individual file copies to allow lazy.nvim to manage its lock file
  xdg.configFile = {
    "nvim/init.lua".source = ../../nvim/init.lua;
    "nvim/stylua.toml".source = ../../nvim/stylua.toml;
    "nvim/lazyvim.json".source = ../../nvim/lazyvim.json;
    "nvim/lua".source = ../../nvim/lua;
    # Don't copy lazy-lock.json - let lazy.nvim manage it at runtime
  };

  # Ensure the nvim data directory exists for lazy.nvim
  home.activation.createNvimDirs = ''
    mkdir -p ${config.home.homeDirectory}/.local/share/nvim
    mkdir -p ${config.home.homeDirectory}/.config/nvim
  '';
}
