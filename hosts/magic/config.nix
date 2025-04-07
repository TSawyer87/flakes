{
  pkgs,
  host,
  systemSettings,
  options,
  lib,
  ...
}: {
  imports = [
    ./hardware.nix
    ./users.nix
    ../../nixosModules
  ];

  # Enable or Disable Stylix
  stylixModule.enable = true;

  # Enable User module
  users.enable = true;
  users = {mutableUsers = true;};

  # Custom Cachix enable
  gytix.cachix.enable = true;

  vm.guest-services.enable = false;
  local.hardware-clock.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "${host}";
  networking.timeServers =
    options.networking.timeServers.default
    ++ ["pool.ntp.org"];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # nixpkgs.config.permittedInsecurePackages = ["olm-3.2.16"];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  # Extra Portal Configuration
  systemd.services.flatpak-repo = {
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = false;
  virtualisation.podman = {
    enable = false;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = false;
  };

  console.keyMap = systemSettings.keyboardLayout;

  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
