{ pkgs, lib, ... }:

let mod = "Mod4";
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
    config = rec {
      modifier = mod;
      terminal = "${pkgs.ghostty}/bin/ghostty";
      startup = [{ command = "firefox"; }]; # Moved here
      # Keybindings will be merged from keybinds.nix
      floating.border = 0;
      window.border = 0;
    };
    extraConfig = ''
      seat * xcursor_theme bibata_modern_ice 26
      # Explicitly set modifier
      set $mod Mod4

      # Start other utilities
      exec waybar &
      exec nm-applet --indicator
      exec wl-paste --type text --watch cliphist store
      exec wl-paste --type image --watch cliphist store

      output DP-1 {
      bg ~/Pictures/Wallpapers/mountains1.jpg fill
        mode 3840x2160@65Hz
        scale 1.5
        pos 0 0
      }

      output HDMI-A-1 {
      # background ~/Pictures/Wallpapers/mountains2.jpg fill
        mode 1920x1080@100Hz
        scale 1
        pos 2560 0  
      }

      input * {
        repeat_delay 300
        repeat_rate 50
      }
      # exec sleep 2 && ${pkgs.wpaperd}/bin/wpaperd -d
    '';
  };

  # systemd service for wpaperd
  systemd.user.services.wpaperd = {
    description = "wpaperd wallpaper daemon";
    wantedBy = [ "sway-session.target" ];
    after = [ "sway-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.wpaperd}/bin/wpaperd -d";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  services = {
    network-manager-applet.enable = true;
    cliphist.enable = true;
  };

  home.packages = with pkgs; [
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
