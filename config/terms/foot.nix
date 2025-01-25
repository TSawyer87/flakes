{ ... }:

{

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono:size=15";
        # Adjust spacing and line-height if needed
        spacing = 0;
        line-height = "1.0";
      };

      fonts = {
        regular = {
          family = "JetBrains Mono";
          style = "Regular";
        };
      };
    };
  };
}
