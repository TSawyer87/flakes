{
  pkgs,
  host,
  options,
  outputs,
  lib,
  ...
}: let
  # Import and inherit values from another Nix file
  inherit (import ./variables.nix) keyboardLayout;
in {
  imports = [
    ./hardware.nix
    # ../../modules/nixosModules/users.nix
    # ../../modules/nixosModules/boot.nix
    # ../../modules/nixosModules/security.nix
    # ../../modules/nixosModules/packages.nix
    # ../../modules/nixosModules/programs.nix
    # ../../modules/nixosModules/services.nix
    # ../../modules/nixosModules/hardware.nix
    # ../../modules/nixosModules/zram.nix
    # ../../modules/nixosModules/stylix.nix
    # ../../modules/nixosModules/cachix.nix
    # ../../modules/nixosModules/xdg.nix
    ../../modules/nixosModules/default.nix
    ../../modules/amd-drivers.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    # ../../modules/nixosModules/i18n.nix
    # ../../modules/nixosModules/nix.nix
    # ../../modules/nixosModules/guix.nix
    # ../../modules/nixosModules/environmentVariables.nix
    # ../../modules/nixosModules/fonts.nix
    # ../../modules/nixosModules/firewall.nix
    # ../../modules/nixosModules/dns.nix
    #    ../../config/firefox.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      # outputs.overlays.rust-overlay

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
  # Enable or Disable Stylix
  stylixModule.enable = true;

  # Enable User module
  users.enable = true;

  # Custom Cachix enable
  gytix.cachix.enable = true;

  # Extra Module Options
  # drivers.amdgpu.enable = true;
  drivers.nvidia.enable = false;
  drivers.nvidia-prime = {
    enable = false;
    intelBusID = "";
    nvidiaBusID = "";
  };
  drivers.intel.enable = false;
  vm.guest-services.enable = true;
  local.hardware-clock.enable = false;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = host;
  networking.timeServers =
    options.networking.timeServers.default
    ++ ["pool.ntp.org"];

  # Set your time zone.
  time.timeZone = "America/New_York";

  nixpkgs.config.permittedInsecurePackages = ["olm-3.2.16"];

  users = {mutableUsers = true;};

  # Extra Portal Configuration
  systemd.services.flatpak-repo = {
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  console.keyMap = "${keyboardLayout}";

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "codeium"
    ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
