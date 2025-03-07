{ pkgs, username, inputs, ... }: {
  # Home Manager Settings
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  # Import Program Configurations
  imports = [
    ../../modules/homeManagerModules/hypr
    # ../../modules/sway
    #../../config/nvf.nix
    ../../modules/homeManagerModules/rofi
    ../../modules/shells
    ../../modules/terms
    #../../modules/homeManagerModules/nvim
    ../../modules/homeManagerModules/zed.nix
    ../../modules/homeManagerModules/nixVim
    ../../modules/homeManagerModules
  ];

  home.packages = with pkgs; [
    lldb
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Styling Options ##Disable if you want independent colorscheming for said app##
  stylix.targets.waybar.enable = false;
  # stylix.targets.wofi.enable = false;
  stylix.targets.rofi.enable = false;
  stylix.targets.hyprland.enable = false;
  stylix.targets.zed.enable = true;
}
