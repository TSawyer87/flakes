{ pkgs, wallpapers }:

pkgs.writeShellScriptBin "show-wallpapers" ''
  #!/bin/sh
  WALLPAPER_DIR=$(nix-build --expr 'pkgs.wallpapers-package' -o /tmp/wallpapers_pkg && echo "/tmp/wallpapers_pkg/share/wallpapers")
  if [ -d "$WALLPAPER_DIR" ]; then
    echo "Available wallpapers:"
    ls "$WALLPAPER_DIR"
  else
    echo "Wallpaper directory not found."
  fi
''
