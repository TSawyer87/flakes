{ config, pkgs, host, username, options, lib, ... }:
let
  drivers = [
    "amdgpu"
    #"intel"
    # "nvidia"
    "amdcpu"
    # "intel-old"
  ];

  # Define the hardware configuration based on config
  hasAmdCpu = builtins.elem "amdcpu" drivers;
  hasIntelCpu = builtins.elem "intel" drivers;
  hasAmdGpu = builtins.elem "amdgpu" drivers;
  hasNvidia = builtins.elem "nvidia" drivers;
  hasOlderIntelCpu = builtins.elem "intel-old" drivers;

  # Define when Mesa is needed based on hardware configuration
  needsMesa = hasAmdGpu || hasIntelCpu || hasOlderIntelCpu;

  # Import and inherit values from another Nix file
  inherit (import ./variables.nix) keyboardLayout;
in
{
  imports = [
    ./hardware.nix
    ./users.nix
    ../../modules/amd-drivers.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    #    ../../config/firefox.nix
  ];

  # ===== Hardware Configuration =====
  hardware = {
    # Existing config
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = pkgs.lib.flatten (with pkgs; [
        # AMD GPU packages
        (lib.optional hasAmdGpu amdvlk)

        # Nvidia GPU packages
        (lib.optional hasNvidia nvidia-vaapi-driver)
        (lib.optional hasNvidia libva-vdpau-driver)

        # Intel Cpu packages
        (lib.optional hasIntelCpu intel-media-driver)
        (lib.optional hasOlderIntelCpu intel-vaapi-driver)

        # Mesa
        (lib.optional needsMesa mesa)
      ]);
      extraPackages32 = pkgs.lib.flatten (with pkgs; [
        # AMD GPU packages
        (lib.optional hasAmdGpu amdvlk)

        # Nvidia GPU packages
        (lib.optional hasNvidia libva-vdpau-driver)

        # Intel Cpu packages
        (lib.optional hasIntelCpu intel-media-driver)
        (lib.optional hasOlderIntelCpu intel-vaapi-driver)

        # Mesa
        (lib.optional needsMesa mesa)
      ]);
    };

    # CPU Configuration
    cpu = {
      amd.updateMicrocode = hasAmdCpu;
      intel.updateMicrocode = hasIntelCpu || hasOlderIntelCpu;
    };

    # Nvidia specific configuration
    nvidia = pkgs.lib.mkIf hasNvidia {
      modesetting.enable = true;
      powerManagement = { enable = false; };
      open = false;
      nvidiaSettings = true;
      forceFullCompositionPipeline = true;
    };
  };

  # Boot configuration for GPU support
  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_zen;

    # Kernel modules and parameters for GPU support
    kernelModules = with pkgs.lib;
      [ "v4l2loopback" ] # For OBS Virtual Cam Support
      ++ (optionals hasAmdCpu [ "kvm-amd" ])
      ++ (optionals (hasIntelCpu || hasOlderIntelCpu) [ "kvm-intel" ])
      ++ (optionals hasAmdGpu [ "amdgpu" ])
      ++ (optionals hasNvidia [ "nvidia" "nvidia_drm" "nvidia_modeset" ]);

    kernelParams = with pkgs.lib;
      (optionals hasAmdCpu [ "amd_pstate=active" ])
      ++ (optionals hasAmdGpu [ "radeon.si_support=0" "amdgpu.si_support=1" ])
      ++ (optionals hasNvidia [ "nvidia-drm.modeset=1" ]);

    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    # Needed For Some Steam Games
    kernel.sysctl = { "vm.max_map_count" = 2147483642; };

    # Module blacklisting
    blacklistedKernelModules = with pkgs.lib;
      (optionals hasAmdGpu [ "radeon" ])
      ++ (optionals hasNvidia [ "nouveau" ]);

    # Extra modprobe config for Nvidia
    extraModprobeConfig = pkgs.lib.mkIf hasNvidia ''
      options nvidia-drm modeset=1
      options nvidia NVreg_PreserveVideoMemoryAllocations=1
    '';

    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%";
    };

    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
      magicOrExtension = "\\x7fELF....AI\\x02";
    };
    plymouth.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # (writeScriptBin "performance_hook" ''
    #   #!/usr/bin/env bash
    #   ${pkgs.bash}/bin/bash /home/jr/scripts/performance_hook.sh
    # '')
    # GPU support packages
    # (lib.optional needsMesa mesa)
    # (lib.optional hasAmdGpu vulkan-tools)
    # (lib.optional hasAmdGpu vulkan-loader)
    # (lib.optional hasAmdGpu vulkan-validation-layers)
    # (lib.optional hasAmdGpu amdvlk)
    # (lib.optional hasNvidia nvidia-vaapi-driver)
    # (lib.optional hasNvidia libva-vdpau-driver)
    # (lib.optional hasNvidia vulkan-tools)
    # (lib.optional hasNvidia vulkan-loader)
    # (lib.optional hasNvidia vulkan-validation-layers)

    # Additional system packages
    # For Nvidia uncomment the following
    # nvidia-vaapi-driver
    # libva-vdpau-driver
    # vulkan-tools
    # vulkan-loader
    # vulkan-validation-layers
    vim
    mesa
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    amdvlk
    profile-sync-daemon
    wget
    killall
    eza
    git
    cmatrix
    lolcat
    htop
    pokemon-colorscripts
    libvirt
    lxqt.lxqt-policykit
    lm_sensors
    unzip
    unrar
    libnotify
    v4l-utils
    ydotool
    duf
    ncdu
    wl-clipboard
    pciutils
    ffmpeg
    socat
    cowsay
    ripgrep
    lshw
    bat
    pkg-config
    meson
    hyprpicker
    ninja
    brightnessctl
    virt-viewer
    swappy
    appimage-run
    networkmanagerapplet
    markdownlint-cli
    markdownlint-cli2
    yad
    inxi
    playerctl
    nh
    nixfmt-classic
    #discord
    swww
    grim
    slurp
    file-roller
    swaynotificationcenter
    imv
    mpv
    gimp
    pavucontrol
    tree
    cachix
    #spotify
    #neovide
    dconf2nix
    greetd.tuigreet
    hyprls
    jq
    nodePackages.prettier
    prettierd
    ruff
    lazygit
    shfmt
    shellcheck
    nixd
    nodejs_22
    nil
    lua-language-server
    bash-language-server
    stylua
    cliphist
    wofi
    pyprland
    zig_0_12
    unipicker
    nvtopPackages.amd
    dmidecode
    alsa-utils
    nix-diff
    linuxKernel.packages.linux_zen.cpupower
    tradingview
    dconf-editor
    rose-pine-cursor
    nwg-look
    pfetch-rs
  ];
  # Styling Options
  stylix = {
    enable = true;
    # image = ../../config/wallpapers/Dreamy-Aesthetic-Home-Under-Moonlight.png;
    # image = ../../config/wallpapers/Anime-Girl5.png;
    # image = ../../config/wallpapers/Wallpaper.png;
    # image = ../../config/wallpapers/gruvbox-dark-japanese-street.jpg;
    # image = ../../config/wallpapers/5-cm.jpg;
    # image = ../../config/wallpapers/nightTab_backdrop.jpg;
    image = ../../config/wallpapers/Lofi-Cafe1.png;
    # image = ../../config/wallpapers/original-anime-cafe.jpg;
    # base16Scheme = {
    #   base00 = "232136";
    #   base01 = "2a273f";
    #   base02 = "393552";
    #   base03 = "6e6a86";
    #   base04 = "908caa";
    #   base05 = "e0def4";
    #   base06 = "e0def4";
    #   base07 = "56526e";
    #   base08 = "eb6f92";
    #   base09 = "f6c177";
    #   base0A = "ea9a97";
    #   base0B = "3e8fb0";
    #   base0C = "9ccfd8";
    #   base0D = "c4a7e7";
    #   base0E = "f6c177";
    #   base0F = "56526e";
    # };
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    #cursor.package = pkgs.rose-pine-cursor;
    #cursor.name = "Rose-Pine-Moon";
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
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
  services.psd = {
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
      enable = false;
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
  hardware.pulseaudio.enable = false;

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
        "https://wezterm.cachix.org"
        "https://ghostty.cachix.org"
        "https://neovim-nightly.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        "neovim-nightly.cachix.org-1:feIoInHRevVEplgdZvQDjhp11kYASYCE2NGY9hNrwxY="
      ];
    };
    gc = {
      # Auto weekly garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
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
