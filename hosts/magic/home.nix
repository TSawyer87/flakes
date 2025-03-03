{ pkgs, username, inputs, nix-index-database, ... }: {
  # Home Manager Settings
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  # Import Program Configurations
  imports = [
    ../../config/emoji.nix
    #../../modules/hypr
    ../../modules/sway
    #../../config/nvf.nix
    ../../config/rofi
    ../../config/shells
    ../../config/terms
    # ../../config/neovim.nix
    # ../../config/nvim
    ../../config/zed.nix
    ../../config/nixVim/nixvim.nix
    ../../modules/homeManagerModules
  ];

  home.packages = with pkgs; [ ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Styling Options ##Disable if you want independent colorscheming for said app##
  stylix.targets.waybar.enable = false;
  stylix.targets.rofi.enable = false;
  stylix.targets.hyprland.enable = false;
  stylix.targets.zed.enable = true;
}
