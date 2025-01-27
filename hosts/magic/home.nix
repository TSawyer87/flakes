{ pkgs, username, inputs, ... }: {
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
    ../../config/nvf.nix
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
    ../../modules/homeManagerModules/programs.nix
    ../../modules/homeManagerModules/packages.nix
    ../../modules/homeManagerModules/services.nix
    ../../modules/homeManagerModules/homeFiles.nix
    ../../modules/homeManagerModules/gtk.nix
    ../../modules/homeManagerModules/qt.nix
  ];

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

  dconf = {
    enable = true;
    settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };

  # Styling Options
  stylix.targets.waybar.enable = false;
  stylix.targets.rofi.enable = false;
  stylix.targets.hyprland.enable = false;
  # qt = {
  #   enable = true;
  #   style.name = "adwaita-dark";
  #   platformTheme.name = "gtk3";
  # };
}
