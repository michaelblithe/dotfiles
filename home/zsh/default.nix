{ config, lib, pkgs, ... }:

{
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "lambda";
        plugins = ["git"];
      };
      shellAliases = {
      } // lib.optionalAttrs (pkgs.stdenv.isLinux) {
        vpn-up = "sudo systemctl stop wg-quick-wg1 2>/dev/null; sudo systemctl start wg-quick-wg0";
        vpn-up-2 = "sudo systemctl stop wg-quick-wg0 2>/dev/null; sudo systemctl start wg-quick-wg1";
        vpn-down = "sudo systemctl stop wg-quick-wg0 2>/dev/null; sudo systemctl stop wg-quick-wg1 2>/dev/null";
      };
    };
}