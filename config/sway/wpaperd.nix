{ pkgs, ... }: {
  home.file.".config/wpaperd/config.toml".text = ''
        [default]
    path = "/home/jr/Pictures/Wallpapers/"
    duration = "30m"
    transition-time = 600

  '';

  systemd.user.services.wpaperd = {
    Unit = {
      description = "wpaperd wallpaper daemon";
      wantedBy = [ "sway-session.target" ];
      after = [ "sway-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.wpaperd}/bin/wpaperd -d";
      ExecStartPre =
        "${pkgs.coreutils}/bin/mkdir -p ~/.cache/fontconfig"; # Ensure cache directory
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
