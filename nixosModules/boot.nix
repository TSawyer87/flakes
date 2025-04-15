{
  config,
  lib,
  pkgs,
  ...
}: let
  zfsCompatibleKernelPackages =
    lib.filterAttrs (
      name: kernelPackages:
        (builtins.match "linux_[0-9]+_[0-9]+" name)
        != null
        && (builtins.tryEval kernelPackages).success
        && (!kernelPackages.${config.boot.zfs.package.kernelModuleAttribute}.meta.broken)
    )
    pkgs.linuxKernel.packages;
  latestKernelPackage = lib.last (
    lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)) (
      builtins.attrValues zfsCompatibleKernelPackages
    )
  );
in {
  boot = {
    supportedFilesystems = ["zfs"];
    zfs.forceImportRoot = false;
    # LinuxZen Kernel
    # kernelPackages = pkgs.linuxPackages_zen;
    # Note this might jump back and forth as kernels are added or removed.
    kernelPackages = latestKernelPackage;
    consoleLogLevel = 3;
    # disable wifi powersave
    extraModprobeConfig = ''
      options iwlmvm  power_scheme=1
      options iwlwifi power_save=0
    '';
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "plymouth.use-simpledrm"
    ];
    kernel.sysctl = {"vm.max_map_count" = 2147483642;};
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
    };
    plymouth.enable = true;
    # kernelModules = ["v4l2loopback"];
    # extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
    # Appimage Support
    # binfmt.registrations.appimage = {
    #   wrapInterpreterInShell = false;
    #   interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    #   recognitionType = "magic";
    #   offset = 0;
    #   mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
    #   magicOrExtension = "\\x7fELF....AI\\x02";
    # };
  };
  networking.hostId = "2d393b76";
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];
}
