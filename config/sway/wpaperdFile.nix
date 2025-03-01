{ ... }: {
  home.file.".config/wpaperd/config.toml".text = ''
        [default]
    path = "/home/jr/Pictures/Wallpapers/"
    duration = "1h"
    transition-time = 600

  '';

}
