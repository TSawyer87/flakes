{ config, pkgs, lib, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      #systemd-boot = { enable = true; };
      grub = {
        efiSupport = true;
        device = "nodev";
        useOSProber = false;
      };
    };
    plymouth.enable = true;
  };

}
