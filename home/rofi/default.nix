{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:

let
  # Plant Pixel theme colors (matching kitty)
  colors = {
    bg = "#0f1210";
    bg-alt = "#141815";
    bg-selected = "#2a332e";
    fg = "#dfeee5";
    fg-alt = "#bfe8cf";
    border = "#77d19a";
    accent = "#6ad3b1";
    urgent = "#cd7a8b";
  };
in
{
  programs.rofi = {
    enable = true;
    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus";
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg = mkLiteral colors.bg;
        bg-alt = mkLiteral colors.bg-alt;
        bg-selected = mkLiteral colors.bg-selected;
        fg = mkLiteral colors.fg;
        fg-alt = mkLiteral colors.fg-alt;
        border = mkLiteral colors.border;
        accent = mkLiteral colors.accent;
        urgent = mkLiteral colors.urgent;

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
      };

      window = {
        width = mkLiteral "600px";
        background-color = mkLiteral "@bg";
        border = mkLiteral "2px";
        border-color = mkLiteral "@border";
        border-radius = mkLiteral "8px";
        padding = mkLiteral "20px";
      };

      mainbox = {
        spacing = mkLiteral "15px";
        children = map mkLiteral [ "inputbar" "listview" ];
      };

      inputbar = {
        children = map mkLiteral [ "prompt" "entry" ];
        background-color = mkLiteral "@bg-alt";
        border-radius = mkLiteral "6px";
        padding = mkLiteral "12px";
      };

      prompt = {
        text-color = mkLiteral "@accent";
        padding = mkLiteral "0 10px 0 0";
      };

      entry = {
        placeholder = "Search...";
        placeholder-color = mkLiteral "@bg-selected";
      };

      listview = {
        lines = 8;
        columns = 1;
        scrollbar = false;
        spacing = mkLiteral "5px";
      };

      element = {
        padding = mkLiteral "10px";
        border-radius = mkLiteral "6px";
      };

      "element normal.normal" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
      };

      "element alternate.normal" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
      };

      "element selected.normal" = {
        background-color = mkLiteral "@bg-selected";
        text-color = mkLiteral "@fg-alt";
      };

      "element normal.urgent, element alternate.urgent" = {
        text-color = mkLiteral "@urgent";
      };

      "element selected.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@bg";
      };

      element-icon = {
        size = mkLiteral "24px";
        margin = mkLiteral "0 10px 0 0";
      };

      element-text = {
        vertical-align = mkLiteral "0.5";
      };
    };
  };
}
