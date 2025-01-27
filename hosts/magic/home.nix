{ pkgs, username, inputs, ... }: {
  # Home Manager Settings
  home = {
  username = "${username}";
  homeDirectory = "/home/${username}";
  stateVersion = "23.11";
        };

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
    ../../modules/homeManagerModules/xdg.nix
    ../../modules/homeManagerModules/dconf.nix
  ];

  home.packages = with pkgs;
    [

    ];

  # dconf = {
  #   enable = true;
  #   settings = {
  #     "org/virt-manager/virt-manager/connections" = {
  #       autoconnect = [ "qemu:///system" ];
  #       uris = [ "qemu:///system" ];
  #     };
  #   };
  # };

  # Styling Options
  stylix.targets.waybar.enable = false;
  stylix.targets.rofi.enable = false;
  stylix.targets.hyprland.enable = false;
}
