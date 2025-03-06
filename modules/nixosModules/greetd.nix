{ pkgs, config, inputs, lib, ... }:
let
  hypr = lib.getExe
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland ''
      exec "${config.programs.regreet.package}/bin/regreet; ${config.programs.hyprland.package}/bin/Hyprland exit"
    '';
in {

  programs.regreet.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${config.programs.hyprland.package}/bin/Hyprland --config ${hypr}";
      };
    };
  };

}

