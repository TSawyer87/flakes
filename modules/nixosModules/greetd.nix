{ pkgs, config, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "Hyprland --config /home/jr/flakes/modules/hypr/config.nix";
        user = "greeter";
      };
    };
  };
  programs.regreet.enable = true;
}
