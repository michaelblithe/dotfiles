{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.wakeonlan ];
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "lambda";
      plugins = [ "git" ];
    };
    shellAliases = {
      claude-gemma = "ANTHROPIC_BASE_URL=http://house-of-wind:8001 claude --model gemma-4-31B-it";
      claude-qwen-27 = "ANTHROPIC_BASE_URL=http://house-of-wind:8001 claude --model unsloth/Qwen3.5-27B-GGUF:UD-Q4_K_XL";
      wake-house-of-wind = "wakeonlan 9c:bf:0d:00:fe:fb";
      t = "$EDITOR ~/sync/everything/Life/Todo.md";
      nt = "$EDITOR ~/sync/everything/Life/$(date %m-%d-+%Y).md";
    }
    // lib.optionalAttrs (pkgs.stdenv.isLinux) {
      sleep = "systemctl suspend";
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
