{ pkgs, inputs, config, lib, ... }:
with lib; {
  options = { stylixModule = { enable = mkEnableOption "enables stylix"; }; };

  config = mkIf config.stylixModule.enable {
    stylix = {
      # enable = true;
      #image = ../../config/wallpapers/Lofi-Cafe1.png;
      # image = ../../config/wallpapers/bookmarks.png;
      # image = ../../config/wallpapers/keinbackup.png;
      image = ../../config/wallpapers/Under_Starlit_Sky.png;
      base16Scheme = {
        base00 = "1D2021";
        base01 = "32302F";
        base02 = "504945";
        base03 = "665C54";
        base04 = "928374";
        base05 = "A89984";
        base06 = "D5C4A1";
        base07 = "FDF4C1";
        base08 = "FB543F";
        base09 = "FE8625";
        base0A = "FAC03B";
        base0B = "95C085";
        base0C = "8BA59B";
        base0D = "0D6678";
        base0E = "8F4673";
        base0F = "A87322";
      };
      polarity = "dark";
      opacity.terminal = 0.8;
      # cursor.package = pkgs.bibata-cursors;
      cursor.package =
        inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
      cursor.name = "BreezeX-RosePine-Linux";
      # cursor.name = "Bibata-Modern-Ice";
      cursor.size = 26;
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.fira-mono;
          name = "Fira-Mono";
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
