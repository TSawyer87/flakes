{ config, pkgs, host, username, options, lib, inputs, ... }:
let
  # Import and inherit values from another Nix file
  inherit (import ./variables.nix) keyboardLayout;
in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./boot.nix
    ./systemPackages.nix
    ../../modules/amd-drivers.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    #    ../../config/firefox.nix
  ];

  # environment.systemPackages = with pkgs; [
  #   inputs.nix-inspect.packages.${pkgs.system}.default
  #   inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  #   #rose-pine-cursor
  #   vim
  #   vulkan-loader
  #   vulkan-validation-layers
  #   vulkan-tools
  #   amdvlk
  #   profile-sync-daemon
  #   wget
  #   killall
  #   eza
  #   git
  #   cmatrix
  #   lolcat
  #   efibootmgr
  #   htop
  #   pokemon-colorscripts-mac
  #   libvirt
  #   lxqt.lxqt-policykit
  #   lm_sensors
  #   unzip
  #   unrar
  #   libnotify
  #   v4l-utils
  #   ydotool
  #   duf
  #   ncdu
  #   wl-clipboard
  #   pciutils
  #   ffmpeg
  #   socat
  #   cowsay
  #   ripgrep
  #   lshw
  #   bat
  #   pkg-config
  #   meson
  #   hyprpicker
  #   ninja
  #   brightnessctl
  #   virt-viewer
  #   swappy
  #   appimage-run
  #   networkmanagerapplet
  #   markdownlint-cli
  #   markdownlint-cli2
  #   yad
  #   inxi
  #   playerctl
  #   nh
  #   nixfmt-classic
  #   #discord
  #   stdenv
  #   swww
  #   grim
  #   slurp
  #   file-roller
  #   swaynotificationcenter
  #   imv
  #   mpv
  #   gimp
  #   pavucontrol
  #   tree
  #   cachix
  #   #spotify
  #   #neovide
  #   dconf2nix
  #   greetd.tuigreet
  #   hyprls
  #   jq
  #   nodePackages.prettier
  #   prettierd
  #   ruff
  #   lazygit
  #   shfmt
  #   shellcheck
  #   nixd
  #   nodejs_22
  #   nil
  #   lua-language-server
  #   bash-language-server
  #   stylua
  #   cliphist
  #   wofi
  #   pyprland
  #   zig_0_12
  #   unipicker
  #   nvtopPackages.amd
  #   dmidecode
  #   alsa-utils
  #   nix-diff
  #   manix
  #   linuxKernel.packages.linux_zen.cpupower
  #   tradingview
  #   dconf-editor
  #   rose-pine-cursor
  #   pfetch-rs
  #   rustup
  #   rustc
  #   rustfmt
  #   cargo
  #   fwupd
  #   openssl
  #   pkg-config
  #   gccgo14
  #   go
  #   gomuks
  #   olm
  # ];
  # Styling Options
  stylix = {
    enable = true;
    #image = ../../config/wallpapers/Lofi-Cafe1.png;
    # image = ../../config/wallpapers/bookmarks.png;
    # image = ../../config/wallpapers/keinbackup.png;
    image = ../../config/wallpapers/Under_Starlit_Sky.png;
    base16Scheme = {
      base00 = "1D2021";
      base01 = "32302F";
      base02 = "504945";
      base03 = "665C54";
      base04 = "928374";
      base05 = "A89984";
      base06 = "D5C4A1";
      base07 = "FDF4C1";
      base08 = "FB543F";
      base09 = "FE8625";
      base0A = "FAC03B";
      base0B = "95C085";
      base0C = "8BA59B";
      base0D = "0D6678";
      base0E = "8F4673";
      base0F = "A87322";
    };
    polarity = "dark";
    opacity.terminal = 0.8;
    # cursor.package = pkgs.bibata-cursors;
    cursor.package =
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
    cursor.name = "BreezeX-RosePine-Linux";
    # cursor.name = "Bibata-Modern-Ice";
    cursor.size = 26;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-mono;
        name = "Fira-Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };

  # Extra Module Options
  # drivers.amdgpu.enable = true;
  drivers.nvidia.enable = false;
  drivers.nvidia-prime = {
    enable = false;
    intelBusID = "";
    nvidiaBusID = "";
  };
  drivers.intel.enable = false;
  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = host;
  networking.timeServers = options.networking.timeServers.default
    ++ [ "pool.ntp.org" ];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  programs = {
    thunderbird.enable = true;
    yazi = { enable = true; };
    firefox.enable = true;
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        buf = { symbol = " "; };
        c = { symbol = " "; };
        directory = { read_only = " 󰌾"; };
        docker_context = { symbol = " "; };
        fossil_branch = { symbol = " "; };
        git_branch = { symbol = " "; };
        golang = { symbol = " "; };
        hg_branch = { symbol = " "; };
        hostname = { ssh_symbol = " "; };
        lua = { symbol = " "; };
        memory_usage = { symbol = "󰍛 "; };
        meson = { symbol = "󰔷 "; };
        nim = { symbol = "󰆥 "; };
        nix_shell = { symbol = " "; };
        nodejs = { symbol = " "; };
        ocaml = { symbol = " "; };
        package = { symbol = "󰏗 "; };
        python = { symbol = " "; };
        rust = { symbol = " "; };
        swift = { symbol = " "; };
        zig = { symbol = " "; };
      };
    };
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = true;
    steam = {
      enable = false;
      gamescopeSession.enable = false;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];

  users = { mutableUsers = true; };

  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      font-awesome
      # Commenting Symbola out to fix install this will need to be fixed or an alternative found.
      symbola
      material-icons
      fira-code
    ];
  };

  environment.variables = {
    NIXOS = "true";
    NIXOS_VERSION = "25.05";
  };

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  # Services to start
  services.psd = { # profile-sync-daemon for firefox
    enable = true;
    resyncTimer = "1h";
  };

  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };
    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          # Wayland Desktop Manager is installed only for user jr via home-manager!
          user = username;
          # .wayland-session is a script generated by home-manager, which links to the current wayland compositor(sway/hyprland or others).
          # with such a vendor-no-locking script, we can switch to another wayland compositor without modifying greetd's config here.
          #command =
          #  "$HOME/.wayland-session"; # start a wayland session directly without a login manager
          command =
            "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };
    smartd = {
      enable = true;
      autodetect = true;
    };
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    flatpak.enable = false;
    printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };
    gnome.gnome-keyring.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
    syncthing = {
      enable = false;
      user = "${username}";
      dataDir = "/home/${username}";
      configDir = "/home/${username}/.config/syncthing";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    rpcbind.enable = false;
    nfs.server.enable = false;
  };
  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
    disabledDefaultBackends = [ "escl" ];
  };

  # Extra Logitech Support
  hardware.logitech.wireless.enable = false;
  hardware.logitech.wireless.enableGraphical = false;

  # Bluetooth Support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;

  services.fwupd.enable = true;

  services.ollama = {
    enable = false;
    acceleration = "rocm";
    environmentVariables = {
      HCC_AMDGPU_TARGET =
        "gfx1031"; # used to be necessary, but doesn't seem to anymore
    };
    rocmOverrideGfx = "10.3.1";
  };

  #   hardware.printers = {
  #   ensurePrinters = [
  #     {
  #       name = "HP_OfficeJet_Pro_6970_F7873C";
  #       location = "Home";
  #       deviceUri = "ipp://192.168.0.24/ipp/print";
  #       model = "everywhere";
  #       ppdOptions = {
  #         PageSize = "A4";
  #       };
  #     }
  #   ];
  #   ensureDefaultPrinter = "HP_OfficeJet_Pro_6970_F7873C";
  # };
  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  security.pam.services.hyprlock = { };

  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://hyprland.cachix.org"
        "https://ghostty.cachix.org"
        "https://neovim-nightly.cachix.org"
        "https://yazi.cachix.org"
        "https://nix-community.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        "neovim-nightly.cachix.org-1:feIoInHRevVEplgdZvQDjhp11kYASYCE2NGY9hNrwxY="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    # gc = {
    #   # Auto weekly garbage collection
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 7d";
    # };
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # OpenGL
  #hardware.graphics = { enable = true; };

  console.keyMap = "${keyboardLayout}";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
