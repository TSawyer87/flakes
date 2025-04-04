{pkgs, ...}: {
  home.packages = with pkgs; [pyprland];

  home.file.".config/hypr/pyprland.toml" = {
    source = ../hypr/pyprland.toml;
    recursive = true;
  };
}
