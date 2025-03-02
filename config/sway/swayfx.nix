{ inputs, pkgs, ... }:
let system = "x86_64-linux";
in {
  home.file.".config/swayfx/config".text = ''
    backend = "scenefx";
    scenefx_config = "~/.config/scenefx/config";
  '';

  home.file.".config/scenefx/config".text = ''
    blur_enable = true;
    blur_passes = 3;
    blur_deviation = 5.0;
    blur_noise = 0.0;
    blur_noise_scale = 1.0;
    blur_noise_seed = 0;
    blur_brightness = 1.0;
    blur_contrast = 1.0;
    blur_temperature = 0.0;
    blur_saturation = 1.0;
    blur_gamma = 1.0;
  '';

  wayland.windowManager.sway.config.startup = [{
    command = "${inputs.swayfx.packages.${pkgs.system}.swayfx}/bin/swayfx";
  }];
}
