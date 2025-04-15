{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  drivers = [
    "amdgpu"
    #"intel"
    # "nvidia"
    "amdcpu"
    # "intel-old"
  ];

  hasAmdCpu = builtins.elem "amdcpu" drivers;
  hasIntelCpu = builtins.elem "intel" drivers;
  hasAmdGpu = builtins.elem "amdgpu" drivers;

  needsMesa = hasAmdGpu;

  cfg = config.drivers.amdgpu;
in {
  options.drivers.amdgpu = {enable = mkEnableOption "Enable AMD Drivers";};

  config = mkIf cfg.enable {
    # Systemd tmpfiles rules for ROCm HIP
    systemd.tmpfiles.rules = ["L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"];

    # Video drivers configuration for X server
    services.xserver.videoDrivers = ["amdgpu"];

    # Additional hardware configuration based on AMD GPU presence
    hardware = {
      amdgpu.amdvlk.enable = true;
      graphics = {
        enable = true;
        enable32Bit = false;
        extraPackages = pkgs.lib.flatten (with pkgs; [
          (lib.optional hasAmdGpu amdvlk)
          (lib.optional needsMesa mesa)
          rocmPackages.clr.icd # OpenCL
          vulkan-loader # Vulkan runtime
          vulkan-validation-layers # Vulkan debugging (optional)
          vulkan-tools # Vulkan utilities (optional)
          gpu-viewer
        ]);
        extraPackages32 = pkgs.lib.flatten (with pkgs; [
          (lib.optional hasAmdGpu amdvlk)
          (lib.optional needsMesa mesa)
        ]);
      };

      # CPU microcode updates
      cpu = {amd.updateMicrocode = hasAmdCpu;};
    };

    # Boot configuration for AMD GPU support
    boot = {
      kernelModules = ["kvm-amd" "amdgpu" "v4l2loopback"];
      kernelParams = [
        "amd_pstate=active"
        "tsc=unstable"
        "radeon.si_support=0"
        "amdgpu.si_support=1"
      ];
      extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
      blacklistedKernelModules = ["radeon"];
    };
  };
}
