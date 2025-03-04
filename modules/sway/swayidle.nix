{ pkgs, ... }:
{
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock && swaylock -f -i /home/jr/flakes/modules/wallpapers/wallpaper1.png";
      }
      {
        event = "lock";
        command = "lock";
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
