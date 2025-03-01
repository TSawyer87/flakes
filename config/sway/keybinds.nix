{ config, pkgs, lib, ... }:
let mod = "Mod4";
in {
  wayland.windowManager.sway = {

    config = {
      modifier = mod;
      keybindings = lib.attrsets.mergeAttrsList [
        (lib.attrsets.mergeAttrsList (map (num:
          let ws = toString num;
          in {
            "${mod}+${ws}" = "workspace ${ws}";
            "${mod}+Ctrl+${ws}" = "move container to workspace ${ws}";
          }) [ 1 2 3 4 5 6 7 8 9 0 ]))

        (lib.attrsets.concatMapAttrs (key: direction: {
          "${mod}+${key}" = "focus ${direction}";
          "${mod}+Shift+${key}" = "move ${direction}";
        }) {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
        })

        {
          "${mod}+Return" = "exec --no-startup-id ${pkgs.ghostty}/bin/ghostty";
          "${mod}+t" = "exec --no-startup-id ${pkgs.kitty}/bin/kitty";
          "${mod}+space" = "exec --no-startup-id wofi --show drun,run";

          "${mod}+Ctrl+x" = "exit";

          "${mod}+a" = "focus parent";
          "${mod}+e" = "layout toggle split";
          "${mod}+f" = "exec firefox";
          "Alt+Return" = "fullscreen toggle";
          "${mod}+g" = "split h";
          "${mod}+v" =
            "exec bash -c 'cliphist list | ${pkgs.wofi}/bin/wofi --dmenu --width 600 --height 400 | cliphist decode | wl-copy'";
          "${mod}+s" = "layout stacking";
          "${mod}+Shift+W" = "exec wpaperd &";
          "${mod}+n" = "exec thunar";
          "${mod}+w" = "layout tabbed";

          "${mod}+Shift+r" = "exec swaymsg reload";
          "--release Print" =
            "exec --no-startup-id ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
          "${mod}+Ctrl+l" = "exec ${pkgs.swaylock-fancy}/bin/swaylock-fancy";
          "${mod}+q" = "kill";
        }
      ];
      focus.followMouse = true;
      workspaceAutoBackAndForth = true;
    };
    systemd.enable = true;
    wrapperFeatures = { gtk = true; };
  };

}
