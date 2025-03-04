{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.jr.opt.services.kanshi;
in
{
  options.jr.opt.services.kanshi.enable = mkEnableOption "kanshi";

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [ kanshi ];
    };
    services.kanshi = {
      enable = true;
      #      systemdTarget = "sway-session.target";
      settings = [
        {
          profile.name = "home";
          profile.outputs = [
            {
              criteria = "Sceptre Tech Inc Sceptre Z27 (DP-1)";
              # mode = "3840x2160@65";
              mode = "2560x1440@65";
              status = "enable";
              position = "0,0";
              scale = 1.0;
            }
            {
              criteria = "ViewSonic Corporation VA2447 100Hz WE3234703733 (HDMI-A-1)";
              mode = "1920x1080@100";
              position = "2560,0";
              scale = 1.0;
            }
          ];
        }
      ];
    };
  };
}
