{ pkgs, inputs, config, lib, ... }:
with lib; {
  options = { stylixModule = { enable = mkEnableOption "enables stylix"; }; };

  config = mkIf config.stylixModule.enable {
    stylix = {
      enable = true;
      #image = ../../config/wallpapers/Lofi-Cafe1.png;
      # image = ../../config/wallpapers/bookmarks.png;
      # image = ../../config/wallpapers/keinbackup.png;
      image = ../wallpapers/Under_Starlit_Sky.png;
      base16Scheme = {
        # Ayu Dark
        base00 = "0F1419";
        base01 = "131721";
        base02 = "272D38";
        base03 = "3E4B59";
        base04 = "BFBDB6";
        base05 = "E6E1CF";
        base06 = "E6E1CF";
        base07 = "F3F4F5";
        base08 = "F07178";
        base09 = "FF8F40";
        base0A = "FFB454";
        base0B = "B8CC52";
        base0C = "95E6CB";
        base0D = "59C2FF";
        base0E = "D2A6FF";
        base0F = "E6B673";
      };

      # base16Scheme = {
      #   # TokyoNightStorm
      #   base00 = "24283B";
      #   base01 = "16161E";
      #   base02 = "343A52";
      #   base03 = "444B6A";
      #   base04 = "787C99";
      #   base05 = "A9B1D6";
      #   base06 = "CBCCD1";
      #   base07 = "D5D6DB";
      #   base08 = "C0CAF5";
      #   base09 = "A9B1D6";
      #   base0A = "0DB9D7";
      #   base0B = "9ECE6A";
      #   base0C = "B4F9F8";
      #   base0D = "2AC3DE";
      #   base0E = "BB9AF7";
      #   base0F = "F7768E";
      # };
      polarity = "dark";
      opacity.terminal = 0.8;
      cursor.package = pkgs.bibata-cursors;
      # cursor.package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
      # cursor.name = "BreezeX-RosePine-Linux";
      cursor.name = "Bibata-Modern-Ice";
      cursor.size = 26;
      fonts = {
        monospace = {
          package = lib.mkDefault pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrains Mono";
        };
        sansSerif = {
          package = pkgs.montserrat;
          name = "Montserrat";
        };
        serif = {
          package = pkgs.montserrat;
          name = "Montserrat";
        };
        sizes = {
          applications = 12;
          terminal = 15;
          desktop = 11;
          popups = 12;
        };
      };
    };
  };
}

