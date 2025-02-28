{ pkgs, lib, ... }:
let
  mod = "Mod4";
  # monitor="$(swaymsg -t get_outputs | jq '.[] | select(.focused) | .name' -r)"
  # ${pkgs.rofi}/bin/rofi -show drun -modi drun -monitor "$monitor" $@;
in {
  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      width = 250;
    };
  };
  wayland.windowManager.sway = {
    enable = true;
    extraConfig = ''
      # ... other sway config
      exec waybar &
      exec nm-applet --indicator
      exec killall -q swww;sleep .5 && swww init

      output DP-1 {
        mode 3840x2160@65Hz
        scale 1.5
        pos 0 0
      }

      output HDMI-A-1 {
        mode 1920x1080@100Hz
        scale 1
        pos 2560 0  
      }

      input * {
        repeat_delay 300
        repeat_rate 50
      }
      exec sleep 1.5 && swww img /home/jr/Pictures/Wallpapers/mountains1.jpg
      # exec swaybg -i /home/jr/Pictures/Wallpapers/mountains1.jpg -m fill
    '';
    config = {
      # gaps = {
      #   bottom = 5;
      #   horizontal = 5;
      #   vertical = 5;
      #   inner = 5;
      #   left = 5;
      #   outer = 5;
      #   right = 5;
      #   top = 5;
      #   smartBorders = "on";
      #   smartGaps = true;
      # };

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
          "${mod}+s" = "layout stacking";
          "${mod}+n" = "exec thunar";
          "${mod}+v" = "split v";
          "${mod}+w" = "layout tabbed";
          "${mod}+Shift+Return" = "exec pypr toggle term";

          "${mod}+Shift+r" = "exec swaymsg reload";
          "--release Print" =
            "exec --no-startup-id ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
          "${mod}+Ctrl+l" = "exec ${pkgs.swaylock-fancy}/bin/swaylock-fancy";
          "${mod}+q" = "kill";
        }
      ];
      focus.followMouse = true;
      startup = [{ command = "firefox"; }];
      workspaceAutoBackAndForth = true;
    };
    systemd.enable = true;
    wrapperFeatures = { gtk = true; };
  };

  services.network-manager-applet.enable = true;
  # programs.waybar = {
  #   enable = true;
  #   systemd.enable = true;
  # };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    XKB_DEFAULT_OPTIONS =
      "terminate:ctrl_alt_bksp,caps:escape,altwin:swap_alt_win";
    SDL_VIDEODRIVER = "wayland";

    # needs qt5.qtwayland in systemPackages
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # Fix for some Java AWT applications (e.g. Android Studio),
    # use this if they aren't displayed properly:
    # _JAVA_AWT_WM_NONREPARENTING = 1;

    # gtk applications on wayland
    # export GDK_BACKEND=wayland
  };

  # home.file.".hm-graphical-session".text = pkgs.lib.concatStringsSep "\n" [
  #   "export MOZ_ENABLE_WAYLAND=1"
  #   "export NIXOS_OZONE_WL=1" # Electron
  # ];

  services.cliphist.enable = true;

  # services.kanshi = { # just will not work
  #   enable = true;
  #   settings = [{
  #     output = {
  #       DP-1 = {
  #         status = "enable";
  #         mode = "3840x2160@65Hz";
  #         scale = 1.5;
  #         position = "0,0";
  #       };
  #       HDMI-A-1 = {
  #         status = "enable";
  #         mode = "1920x1080@100Hz";
  #         scale = 1.0;
  #         position = "2560,0";
  #       };
  #     };
  #   }];
  # };

  home.packages = with pkgs; [
    grim
    mako # notifications
    swaybg
    wl-clipboard
    cliphist
    wlogout
    rofi-wayland
    slurp
    grim
    swww
    swaynotificationcenter
    pavucontrol
    swappy
    networkmanagerapplet
    wofi
    pyprland
    yad
  ];
}
