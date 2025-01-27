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
    #../../config/nixVim/nixvim.nix
    ../../modules/homeManagerModules/homePrograms.nix
    ../../modules/homeManagerModules/homePackages.nix
    ../../modules/homeManagerModules/homeServices.nix
    ../../modules/homeManagerModules/homeFiles.nix
    inputs.nvf.homeManagerModules.default
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

}
