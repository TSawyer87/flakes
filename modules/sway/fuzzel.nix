{ pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.ghostty}/bin/ghostty";
      };
      args = [
        "--dmenu"
        "--width=65"
      ];
    };
  };
}
