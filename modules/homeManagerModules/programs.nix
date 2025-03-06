{ pkgs, ... }:
let inherit (import ../../hosts/magic/variables.nix) gitUsername gitEmail;
in {
  programs = {
    home-manager.enable = true;
    # direnv = {
    #   enable = true;
    #   enableBashIntegration = true; # see note on other shells below
    #   nix-direnv.enable = true;
    # };
    nh = {
      enable = true;
      # clean.enable = true;
      # clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/jr/flakes";
    };

    bat.enable = true;
    gh.enable = true;
    btop = {
      enable = true;
      settings = { vim_keys = true; };
    };
    hyprlock = {
      enable = false;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 10;
          hide_cursor = true;
          no_fade_in = false;
        };
      };
    };
    # foot = {
    #   enable = true;
    #   server.enable = true;
    #   settings = {
    #     main = {
    #       term = "xterm-256color";
    #       font = "JetBrainsMono Nerd Font Mono:size=15";
    #       dpi-aware = "no";
    #     };
    #     mouse = { hide-when-typing = "yes"; };
    #   };
    # };

    zathura = { enable = true; };

    go = { enable = true; };

    # nix-index = { enable = true; }; # nix-locate
  };
}
