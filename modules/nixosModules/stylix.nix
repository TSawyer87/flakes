{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
with lib; {
  options = {
    stylixModule = {
      enable = mkEnableOption "enables stylix";
    };
  };

  config = mkIf config.stylixModule.enable {
    stylix = {
      enable = true;
      #image = ../../config/wallpapers/Lofi-Cafe1.png;
      # image = ../../config/wallpapers/bookmarks.png;
      # image = ../../config/wallpapers/keinbackup.png;
      image = ../../config/wallpapers/Under_Starlit_Sky.png;
      # base16Scheme = {       # Darktooth
      #   base00 = "1D2021";
      #   base01 = "32302F";
      #   base02 = "504945";
      #   base03 = "665C54";
      #   base04 = "928374";
      #   base05 = "A89984";
      #   base06 = "D5C4A1";
      #   base07 = "FDF4C1";
      #   base08 = "FB543F";
      #   base09 = "FE8625";
      #   base0A = "FAC03B";
      #   base0B = "95C085";
      #   base0C = "8BA59B";
      #   base0D = "0D6678";
      #   base0E = "8F4673";
      #   base0F = "A87322";
      # };
      # base16Scheme = {
      #   # Ayu Dark
      #   base00 = "0F1419";
      #   base01 = "131721";
      #   base02 = "272D38";
      #   base03 = "3E4B59";
      #   base04 = "BFBDB6";
      #   base05 = "E6E1CF";
      #   base06 = "E6E1CF";
      #   base07 = "F3F4F5";
      #   base08 = "F07178";
      #   base09 = "FF8F40";
      #   base0A = "FFB454";
      #   base0B = "B8CC52";
      #   base0C = "95E6CB";
      #   base0D = "59C2FF";
      #   base0E = "D2A6FF";
      #   base0F = "E6B673";
      # };

      base16Scheme = {
        # TokyoNightStorm
        base00 = "24283B";
        base01 = "16161E";
        base02 = "343A52";
        base03 = "444B6A";
        base04 = "787C99";
        base05 = "A9B1D6";
        base06 = "CBCCD1";
        base07 = "D5D6DB";
        base08 = "C0CAF5";
        base09 = "A9B1D6";
        base0A = "0DB9D7";
        base0B = "9ECE6A";
        base0C = "B4F9F8";
        base0D = "2AC3DE";
        base0E = "BB9AF7";
        base0F = "F7768E";
      };
      # base16Scheme = {
      #   # TokyoNightTerminal
      #   base00 = "11121d";
      #   base01 = "1A1B2A";
      #   base02 = "212234";
      #   base03 = "282c34";
      #   base04 = "4a5057";
      #   base05 = "a0a8cd";
      #   base06 = "a0a8cd";
      #   base07 = "a0a8cd";
      #   base08 = "ee6d85";
      #   base09 = "f6955b";
      #   base0A = "d7a65f";
      #   base0B = "95c561";
      #   base0C = "38a89d";
      #   base0D = "7199ee";
      #   base0E = "a485dd";
      #   base0F = "773440";
      # };
      # base16Scheme = {  # Catppuccin Mocha
      #   base00 = "1e1e2e"; # base
      #   base01 = "181825"; # mantle
      #   base02 = "313244"; # surface0
      #   base03 = "45475a"; # surface1
      #   base04 = "585b70"; # surface2
      #   base05 = "cdd6f4"; # text
      #   base06 = "f5e0dc"; # rosewater
      #   base07 = "b4befe"; # lavender
      #   base08 = "f38ba8"; # red
      #   base09 = "fab387"; # peach
      #   base0A = "f9e2af"; # yellow
      #   base0B = "a6e3a1"; # green
      #   base0C = "94e2d5"; # teal
      #   base0D = "89b4fa"; # blue
      #   base0E = "cba6f7"; # mauve
      #   base0F = "f2cdcd"; # flamingo
      # };
      polarity = "dark";
      opacity.terminal = 0.8;
      # cursor.package = pkgs.bibata-cursors;
      cursor.package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
      cursor.name = "BreezeX-RosePine-Linux";
      # cursor.name = "Bibata-Modern-Ice";
      cursor.size = 26;
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
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
