{ pkgs, config, ... }:
let
  hypr-conf = pkgs.writeText "greet-config" ''
    exec "${config.programs.regreet.package}/bin/regreet; ${config.programs.hyprland.package}/bin/Hyprland exit"
  '';
in {
  services.greetd.settings.default_session = {
    command =
      "${config.programs.hyprland.package}/bin/Hyprland --config ${hypr-conf}";
  };
  programs.regreet.enable = true;
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     command = "hyprland --config /home/jr/flakes/modules/hypr/hyprland.conf";
  #     #   default_session.command = ''
  #     #     ${pkgs.greetd.regreet}/bin/regreet \
  #     #       --cmd ${pkgs.hyprland}/bin/Hyprland
  #     #       # --cmd ${pkgs.sway}/bin/sway
  #     #   '';
  #   };
  # };

}

