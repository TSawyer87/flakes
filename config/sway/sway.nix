{ pkgs, inputs, swayfx, ... }:

let
  mod = "Mod4";
  system = "x86_64-linux";
in {
  imports = [ ./keybinds.nix ];

  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      width = 250;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false;
    config = rec {
      modifier = mod;
      terminal = "${pkgs.ghostty}/bin/ghostty";
      startup = [{ command = "firefox"; }];
      floating.border = 0;
      window.border = 0;
    };
    extraConfig = ''
      seat * xcursor_theme bibata_modern_ice 26
      set $mod Mod4

      exec waybar &
      exec nm-applet --indicator
      exec wl-paste --type text --watch cliphist store
      exec wl-paste --type image --watch cliphist store

      output DP-1 {
        # bg /home/jr/Pictures/Wallpapers/mountains1.jpg fill
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
      # SwayFx settings
      shadows enable
      blur_radius 7
      blur_passes 4
      exec ${pkgs.wpaperd}/bin/wpaperd -d
    '';
  };

  services = {
    network-manager-applet.enable = true;
    cliphist.enable = true;
  };

  home.packages = with pkgs; [
    swayfx
    scenefx
    grim
    mako
    wl-clipboard
    cliphist
    wlogout
    rofi-wayland
    slurp
    grim
    wpaperd
    swaynotificationcenter
    pavucontrol
    swappy
    networkmanagerapplet
    wofi
    yad
    findutils
    wtype
  ];
}

