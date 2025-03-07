{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      {
        event = "lock";
        command =
          "${pkgs.swaylock}/bin/swaylock"; # or "${pkgs.swaylock}/bin/swaylock -f -i /home/jr/flakes/modules/wallpapers/wallpaper1.png"; if you want wallpaper on all locks.
      }
    ];
    timeouts = [
      {
        timeout = 300; # 5 min
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        timeout = 900; # 15 minutes (900 seconds)
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
