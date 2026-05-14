{ pkgs, catppuccin, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_frappe";
      keys.normal = {
        "^" = "goto_first_nonwhitespace";
        "$" = "goto_line_end";
        "g"."g" = "goto_file_start";
        "G" = "goto_file_end";
        "a" = "append_mode";
      };
    };
  };
}
