{ ... }: {
  programs = {
    foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "JetBrainsMono Nerd Font Mono:size=15";
          dpi-aware = "no";
        };
        mouse = { hide-when-typing = "yes"; };
      };
    };

  };
}
