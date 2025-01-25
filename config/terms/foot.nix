{ ... }:

{

  programs.foot = {
    enable = true;
    server = { enable = true; };
    settings = {
      main = {
        term = "xterm-256color";
        font = "JetBrains Mono Nerd Font Mono:size=15";
      };

    };
  };
}
