{...}: let
  inherit (import ../../hosts/magic/variables.nix) gitUsername gitEmail;
in {
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    bash.enable = true; # see note on other shells below
    git = {
      enable = true;
      userName = "${gitUsername}";
      userEmail = "${gitEmail}";
      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
        ac = "!git add -A && git commit -m ";
      };
      ignores = [
        "*.jj"
      ];
    };
    jujutsu = {
      enable = true;
      settings = {
        user = {
          email = "sawyerjr.25@gmail.com";
          name = "TSawyer87";
        };
      };
    };
    yazi = {
      enable = true;
      shellWrapperName = "y";
      settings = {
        manager = {
          show_hidden = false;
          sort_dir_first = true;
          sort_by = "mtime";
          sort_reverse = true;
          linemode = "size";
          editor = "nvim";
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
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/jr/flakes";
    };

    bat.enable = true;
    gh.enable = true;
    btop = {
      enable = true;
      settings = {vim_keys = true;};
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

    zathura = {enable = true;};

    go = {enable = true;};

    nix-index = {enable = true;}; # nix-locate
  };
}
