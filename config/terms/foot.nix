{ ... }:

{

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono:size=12";
        # Adjust spacing and line-height if needed
        spacing = 0;
        line-height = "1.0";
      };

      fonts = {
        regular = {
          family = "JetBrains Mono";
          style = "Regular";
        };
        bold = {
          family = "JetBrains Mono";
          style = "Bold";
        };
        italic = {
          family = "JetBrains Mono";
          style = "Italic";
        };
        boldItalic = {
          family = "JetBrains Mono";
          style = "Bold Italic";
        };
      };
    };
  };
}
