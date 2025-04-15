{pkgs, ...}: {
  boot = {
    # LinuxZen Kernel
    kernelPackages = pkgs.linuxPackages_zen;
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
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];
}
