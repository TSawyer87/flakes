{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
with lib; {
  options = {stylixModule = {enable = mkEnableOption "enables stylix";};};

  config = mkIf config.stylixModule.enable {
    stylix = {
      enable = true;
      # image = ../modules/wallpapers/Lofi-Cafe1.png;
      image = "${inputs.wallpapers}/Lofi-Cafe1.png";
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
      #   # Catppuccin Mocha
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
      # base16Scheme = {
      #   # Kanagawa
      #   base00 = "1F1F28";
      #   base01 = "16161D";
      #   base02 = "223249";
      #   base03 = "54546D";
      #   base04 = "727169";
      #   base05 = "DCD7BA";
      #   base06 = "C8C093";
      #   base07 = "717C7C";
      #   base08 = "C34043";
      #   base09 = "FFA066";
      #   base0A = "C0A36E";
      #   base0B = "76946A";
      #   base0C = "6A9589";
      #   base0D = "7E9CD8";
      #   base0E = "957FB8";
      #   base0F = "D27E99";
      # };

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
      # cursor.package = pkgs.bibata-cursors;
      # cursor.name = "Bibata-Modern-Ice";
      cursor.package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
      cursor.name = "BreezeX-RosePine-Linux";
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
          applications = lib.mkDefault 12;
          terminal = lib.mkDefault 12;
          desktop = 11;
          popups = 12;
        };
      };
    };
  };
}
