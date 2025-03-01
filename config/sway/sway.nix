{ pkgs, lib, ... }:

let mod = "Mod4";
in {
  imports = [ ./keybinds.nix ]; # Import keybinds.nix at the top level

  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      width = 250;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    terminal = "${pkgs.ghostty}/bin/ghostty";
    startup = [{ command = "firefox"; }];
    extraConfig = ''
      # Explicitly set modifier
      set $mod Mod4

      # Start other utilities
      exec waybar &
      exec nm-applet --indicator
      exec wl-paste --type text --watch cliphist store
      exec wl-paste --type image --watch cliphist store

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
      exec ${pkgs.wpaperd}/bin/wpaperd -d
    '';
    config = {
      modifier = mod;
      # Keybindings will be merged from keybinds.nix if it defines config.keybindings
      # Add any additional Sway-specific config here if needed
    };
  };

  # Top-level Home Manager options (moved out of sway.config)
  services.network-manager-applet.enable = true;

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  services.cliphist.enable = true;

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
    pyprland
    yad
  ];
}
