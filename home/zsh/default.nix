{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "lambda";
      plugins = [ "git" ];
    };
    shellAliases = {
      claude-qwen-35 = "ANTHROPIC_BASE_URL=http://house-of-wind:8001 claude --model bartowski/Qwen_Qwen3.5-35B-A3B-GGUF:Q8_0";
      claude-qwen-27 = "ANTHROPIC_BASE_URL=http://house-of-wind:8001 claude --model unsloth/Qwen3.5-27B-GGUF:UD-Q4_K_XL";
      claude-cascade = "ANTHROPIC_BASE_URL=http://house-of-wind:8001 claude --model mradermacher/Nemotron-Cascade-2-30B-A3B-GGUF:Q8_0";
      claude-cascade-fast = "ANTHROPIC_BASE_URL=http://house-of-wind:8001 claude --model Cascade-2-30B-A3B ";
      t = "$EDITOR ~/sync/everything/Life/Todo.md";
      nt = "$EDITOR ~/sync/everything/Life/$(date %m-%d-+%Y).md";
    }
    // lib.optionalAttrs (pkgs.stdenv.isLinux) {
      nixswitch = "sudo nixos-rebuild switch --flake ~/Documents/dotfiles#$(hostname)";
      vpn-up = "sudo systemctl stop wg-quick-wg1 2>/dev/null; sudo systemctl start wg-quick-wg0";
      vpn-up-2 = "sudo systemctl stop wg-quick-wg0 2>/dev/null; sudo systemctl start wg-quick-wg1";
      vpn-down = "sudo systemctl stop wg-quick-wg0 2>/dev/null; sudo systemctl stop wg-quick-wg1 2>/dev/null";
    }
    // lib.optionalAttrs (pkgs.stdenv.isDarwin) {
      nixswitch = "darwin-rebuild switch --flake ~/Documents/dotfiles#$(hostname)";
    };
    initContent = lib.mkMerge [
      (lib.mkOrder 550 ''
        fpath=(~/Documents/dotfiles/scripts $fpath)
      '')
      ''
        source ~/Documents/dotfiles/scripts/llama-cpp.sh
      ''
    ];
  };
}
