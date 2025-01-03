{ pkgs, username, host, system, inputs, ... }:
let inherit (import ./variables.nix) gitUsername gitEmail;
in {
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  # Import Program Configurations
  imports = [
    ../../config/emoji.nix
    ../../config/fastfetch
    ../../config/hyprland.nix
    ../../config/neovim.nix
    ../../config/rofi/rofi.nix
    ../../config/rofi/config-emoji.nix
    ../../config/rofi/config-long.nix
    ../../config/swaync.nix
    ../../config/waybar.nix
    ../../config/wlogout.nix
    ../../config/fastfetch
    ../../config/zsh.nix
    ../../config/bash.nix
    ../../config/wezterm.nix
    ../../config/kitty.nix
    ../../config/zed.nix
    ../../config/starship.nix
  ];

  # Place Files Inside Home Directory
  home.file."Pictures/Wallpapers" = {
    source = ../../config/wallpapers;
    recursive = true;
  };
  home.file.".config/wlogout/icons" = {
    source = ../../config/wlogout;
    recursive = true;
  };
  home.file.".config/hypr/pyprland.toml" = {
    source = ../../config/pyprland.toml;
    recursive = true;
  };

  # home.file.".face.icon".source = ../../config/face.jpg;
  # home.file.".config/face.jpg".source = ../../config/face.jpg;
  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=/home/${username}/Pictures/Screenshots
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=Ubuntu
    paint_mode=brush
    early_exit=true
    fill_shape=false
  '';

  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };

  # Install & Configure tmux
  programs.tmux = {
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

  programs.zathura = { enable = true; };

  programs.go = { enable = true; };

  programs.nix-index = { enable = true; }; # nix-locate

  # programs.foot = {
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

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    bash.enable = true; # see note on other shells below
  };

  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 14;
      font-family = "Fira-Code-Mono Nerd Font";
      window-decoration = false;
      confirm-close-surface = false;

      # The default is a bit intense for my liking
      # but it looks good with some themes
      unfocused-split-opacity = 0.9;
      background-opacity = 0.8;
      background-blur-radius = 20;

      # Some macOS settings
      window-theme = "dark";

      # Disables ligatures
      font-feature = [ "-liga" "-dlig" "-calt" ];
    };
  };

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

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Styling Options
  stylix.targets.waybar.enable = false;
  stylix.targets.wezterm.enable = true;
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
  # Scripts
  home.packages = [
    inputs.zen-browser.packages."${pkgs.system}".specific
    inputs.hyprland-qtutils.packages."${pkgs.system}".default
    # inputs.ghostty.packages."${pkgs.system}".default
    pkgs.fzf
    pkgs.glow # markdown previewer in terminal
    pkgs.nix-output-monitor # provides `nom` command, works like `nix`
    pkgs.iotop # io monitoring
    pkgs.iftop # network monitoring
    pkgs.usbutils # lsusb
    (import ../../scripts/emopicker9000.nix { inherit pkgs; })
    (import ../../scripts/task-waybar.nix { inherit pkgs; })
    (import ../../scripts/squirtle.nix { inherit pkgs; })
    (import ../../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ../../scripts/wallsetter.nix {
      inherit pkgs;
      inherit username;
    })
    (import ../../scripts/web-search.nix { inherit pkgs; })
    (import ../../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ../../scripts/screenshootin.nix { inherit pkgs; })
    (import ../../scripts/list-hypr-bindings.nix {
      inherit pkgs;
      inherit host;
    })
  ];

  services = {
    hypridle = {
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };

  programs = {
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
        # background = [
        #   {
        #     path = "/home/${username}/Pictures/Wallpapers/Wall.png";
        #     blur_passes = 3;
        #     blur_size = 8;
        #   }
        # ];
        # image = [
        #   {
        #     path = "/home/${username}/.config/5-cm.jpg";
        #     size = 150;
        #     border_size = 4;
        #     border_color = "rgb(0C96F9)";
        #     rounding = -1; # Negative means circle
        #     position = "0, 200";
        #     halign = "center";
        #     valign = "center";
        #   }
        # ];
        # input-field = [
        #   {
        #     size = "200, 50";
        #     position = "0, -80";
        #     monitor = "";
        #     dots_center = true;
        #     fade_on_empty = false;
        #     font_color = "rgb(CFE6F4)";
        #     inner_color = "rgb(657DC2)";
        #     outer_color = "rgb(0D0E15)";
        #     outline_thickness = 5;
        #     placeholder_text = "Password...";
        #     shadow_passes = 2;
        #   }
        # ];
      };
    };

  };
}
