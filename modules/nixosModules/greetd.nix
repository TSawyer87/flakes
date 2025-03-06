{ pkgs, config, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${pkgs.regreet}/bin/regreet --command ${config.programs.hyprland.package}/bin/Hyprland";
      };
    };
  };
  programs.regreet.enable = true;
}
