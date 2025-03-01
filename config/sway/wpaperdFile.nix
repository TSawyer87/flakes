{ pkgs, ... }: {
  home.file.".config/wpaperd/config.toml".text = ''
        [default]
    path = "/home/jr/Pictures/Wallpapers/"
    duration = "30m"
    transition-time = 600

  '';
  # home.file.".cache/fontconfig".source = pkgs.writeTextDir "empty" "";
  # home.file.".cache/fontconfig".recursive = true;

  # Ensure cache directories for Fontconfig
  home.file.".cache/fontconfig".directory = { target = "fontconfig-cache"; };

  home.file.".cache/fontconfig-cache".directory = { mode = "0700"; };

}
