{ config, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${config.programs.hyprland.package}/bin/Hyprland --config /home/jr/flakes/modules/hypr/config.nix";
      };
    };
  };

}

