{ ... }:

{

  programs.foot.server = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "JetBrains Mono:size=15";
        # Adjust spacing and line-height if needed
        spacing = 0;
        line-height = "1.0";
      };

    };
  };
}
