{ pkgs, username, inputs, ... }: {
  # Home Manager Settings
  home = {
    username = "${username}";
    homeDirectory = "/home/" + "${username}";
    stateVersion = "23.11";
  };

  # Import Program Configurations
  imports = [
    ../../homeManagerModules
    # ../../modules/sway
  ];

  home.packages = with pkgs; [
    lldb
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Styling Options ##Disable if you want independent colorscheming for said app##
  stylix.targets.waybar.enable = false;
  stylix.targets.rofi.enable = false;
  stylix.targets.wofi.enable = false;
  stylix.targets.mako.enable = false;
  stylix.targets.hyprland.enable = false;
  stylix.targets.hyprlock.enable = false;
  stylix.targets.zed.enable = true;
  stylix.targets.helix.enable = false;
  stylix.targets.ghostty.enable = false;
  stylix.targets.nvf.enable = false;
}
