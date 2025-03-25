{ pkgs, username, inputs, outputs, ... }: {
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
    # ../../modules/homeManagerModules/nvim
    ../../modules/homeManagerModules/zed.nix
    ../../modules/homeManagerModules/nixVim
    ../../modules/homeManagerModules
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # outputs.overlays.helix-nightly

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # config = {
    #         allowUnfree = true;
    # };
  };
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
  stylix.targets.wofi.enable = false;
  stylix.targets.mako.enable = false;
  stylix.targets.hyprland.enable = false;
  stylix.targets.hyprlock.enable = false;
  stylix.targets.zed.enable = true;
  stylix.targets.helix.enable = false;
}
