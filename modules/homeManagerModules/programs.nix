{ pkgs, ... }:
let inherit (import ../../hosts/magic/variables.nix) gitUsername gitEmail;
in {
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    # jujutsu = {
    #   enable = true;
    #   settings = {
    #     user = {
    #       email = "sawyerjr.25@gmail.com";
    #       name = "TSawyer87";
    #     };
    #   };
    # };
    helix = {
      enable = true;
      package = pkgs.evil-helix;
      extraPackages = [ pkgs.marksman ];
      languages = {
        language = [{
          name = "rust";
          auto-format = true;
        }];
      };
      settings = {
        editor = {
          line-number = "relative";
          lsp.display-messages = true;
        };
        keys.normal = {
          space.space = "file_picker";
          space.w = ":w";
          space.q = ":q";
          esc = [ "collapse_selection" "keep_primary_selection" ];
        };
      };
    };
    tmux = {
      enable = true;
      keyMode = "vi";
      disableConfirmationPrompt = true;
      sensibleOnTop = true;
      terminal = "screen-256color";
      # prefix = "`";
      extraConfig = ''
        unbind C-b
        set-option -g prefix `
        set-option -g mouse on
        # switch panes using Alt-arrow without prefix
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D
      '';
    };
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
    home-manager.enable = true;
    hyprlock = {
      enable = true;
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
