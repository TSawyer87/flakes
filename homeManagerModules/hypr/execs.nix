{...}: {
  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "killall -q waybar;sleep .5 && waybar"
        # "killall -q swaync;sleep .5 && swaync"
        # "sleep 1.5 && swww img /home/${username}/Pictures/Wallpapers/"
        # "killall -q swww;sleep .5 && swww init"
        "udiskie -2"
        "ydotoold"
        "hypridle"
        "nm-applet --indicator"
        # "lxqt-policykit-agent"
        "polkit_gnome"
        "pypr &"
        "blueman-applet"
        "wpaperd"
        "killall -q mako;sleep .5 && mako"
        "wl-paste --type text --watch cliphist store" # Stores only text data
        "wl-paste --type image --watch cliphist store" # Stores only image data
      ];
    };
  };
}
