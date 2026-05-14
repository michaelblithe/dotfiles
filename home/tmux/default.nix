{libs, ...}:

{
  programs.tmux = {
    enable = true;
  };
  catppuccin.tmux = {
    enable = true;
    flavor = "mocha";
  };
}