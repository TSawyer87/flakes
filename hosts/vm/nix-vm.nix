{
  userConfig,
  nixosConfiguration,
  ...
}:
nixosConfiguration.extendModules {
  modules = [
    ({
      config,
      pkgs,
      ...
    }: {
      virtualisation.vmVariant = {
        virtualisation = {
          memorySize = userConfig.vm.memorySize;
          cores = userConfig.vm.cores;
          diskSize = userConfig.vm.diskSize;
          qemu = {
            options = [
              "-device virtio-vga-gl"
              "-display gtk,gl=on,grab-on-hover=on"
              "-usb -device usb-tablet"
              "-cpu host"
              "-enable-kvm"
            ];
          };
        };
        services.xserver = {
          #! you can set this to skip login for sddm
          # displayManager.autoLogin = {
          #   enable = true;
          #   user = userConfig.username;
          # };
          videoDrivers = ["virtio"];
        };
      };
      virtualisation.libvirtd.enable = true;
      environment.systemPackages = with pkgs; [
        open-vm-tools
        spice-gtk
        spice-vdagent
        spice
      ];
      services.qemuGuest.enable = true;
      services.spice-vdagentd = {enable = true;};
      hardware.graphics.enable = true;
    })
  ];
}
