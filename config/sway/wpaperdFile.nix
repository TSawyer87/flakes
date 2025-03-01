{ pkgs, ... }: {
  home.file.".config/wpaperd/config.toml".text = ''
        [default]
    path = "/home/jr/Pictures/Wallpapers/"
    duration = "30m"
    transition-time = 600

  '';
  home.file.".cache/fontconfig".source = pkgs.writeTextDir "empty" "";
  home.file.".cache/fontconfig".recursive = true;

}
