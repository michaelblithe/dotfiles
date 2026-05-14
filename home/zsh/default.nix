{ config, pkgs, ... }:

{
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "lambda";
        plugins = ["git"];
      };
      shellAliases = {
        llama-server-vulkan = "nix shell github:ggml-org/llama.cpp#vulkan --command llama-server";
        llama-server-cuda = "nix shell github:ggml-org/llama.cpp#cuda --command llama-server";
        llama-server-rocm = "nix shell github:ggml-org/llama.cpp#rocm --override-input nixpkgs github:NixOS/nixpkgs/nixos-unstable --command llama-server";
      };
    };
}