{ pkgs, username, host, system, inputs, ... }:
let inherit (import ./variables.nix) gitUsername gitEmail;
in {
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  # Import Program Configurations
  imports = [
    ../../config/emoji.nix
    ../../config/hypr/hyprland.nix
    #../../config/hypr/hyprpanel.nix
    ../../config/hypr/swaync.nix
    ../../config/hypr/waybar.nix
    ../../config/hypr/wlogout.nix
    #../../config/neovim.nix
    ../../config/rofi/rofi.nix
    ../../config/rofi/config-emoji.nix
    ../../config/rofi/config-long.nix
    ../../config/shells/zsh.nix
    ../../config/shells/bash.nix
    ../../config/shells/starship.nix
    ../../config/shells/fastfetch
    # ../../config/terms/wezterm.nix
    ../../config/terms/kitty.nix
    ../../config/terms/ghostty.nix
    ../../config/zed.nix
    ../../config/nixVim/nixvim.nix
    ../../modules/homeManagerModules/homePrograms.nix
    ../../modules/homeManagerModules/homePackages.nix
    ../../modules/homeManagerModules/homeServices.nix
  ];

  # Place Files Inside Home Directory
  home.file."Pictures/Wallpapers" = {
    source = ../../config/wallpapers;
    recursive = true;
  };
  home.file.".config/wlogout/icons" = {
    source = ../../config/wlogout;
    recursive = true;
  };
  home.file.".config/hypr/pyprland.toml" = {
    source = ../../config/hypr/pyprland.toml;
    recursive = true;
  };

  # home.file.".face.icon".source = ../../config/face.jpg;
  # home.file.".config/face.jpg".source = ../../config/face.jpg;
  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=/home/${username}/Pictures/Screenshots
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=Ubuntu
    paint_mode=brush
    early_exit=true
    fill_shape=false
  '';

  # Create XDG Dirs
  xdg = {
    # configFile."mimeapps.list".text = ''
    # [Default Applications]
    # x-scheme-handler/http=zen.desktop
    # x-scheme-handler/https=zen.desktop
    # text/html=zen.desktop
    # application/pdf=org.pwmt.zathura.desktop
    # '';
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Styling Options
  stylix.targets.waybar.enable = false;
  stylix.targets.rofi.enable = false;
  stylix.targets.hyprland.enable = false;
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = 1; };
  };
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
  };
  # services = {
  #
  #   hypridle = {
  #     settings = {
  #       general = {
  #         after_sleep_cmd = "hyprctl dispatch dpms on";
  #         ignore_dbus_inhibit = false;
  #         lock_cmd = "hyprlock";
  #       };
  #       listener = [
  #         {
  #           timeout = 900;
  #           on-timeout = "hyprlock";
  #         }
  #         {
  #           timeout = 1200;
  #           on-timeout = "hyprctl dispatch dpms off";
  #           on-resume = "hyprctl dispatch dpms on";
  #         }
  #       ];
  #     };
  #   };
  # };

}
