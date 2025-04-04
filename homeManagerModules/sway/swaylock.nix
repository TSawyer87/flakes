{
  pkgs,
  lib,
  ...
}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      image = lib.mkDefault "/home/jr/flakes/modules/wallpapers/wallpaper1.png";

      clock = true;
      timestr = "%T";
      datestr = "%F";

      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 7;

      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";

      # text-color = "CDD6F4";
      # text-clear-color = "CDD6F4";
      # text-caps-lock-color = "CDD6F4";
      # text-ver-color = "CDD6F4";
      # text-wrong-color = "CDD6F4";
      #
      # inside-color = "1E1E2EEE";
      # inside-clear-color = "1E1E2EEE";
      # inside-caps-lock-color = "1E1E2EEE";
      # inside-ver-color = "1E1E2EEE";
      # inside-wrong-color = "1E1E2EEE";
      #
      # ring-color = "CBA6F7";
      # ring-clear-color = "FAB387";
      # ring-caps-lock-color = "F5C2E7";
      # ring-ver-color = "89B4Fa";
      # ring-wrong-color = "F38BA8";
      #
      # key-hl-color = "A6E3A1";
      # bs-hl-color = "F38BA8";
    };
  };

  # catppuccin.swaylock.enable = false;
}
