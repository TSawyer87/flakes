{ pkgs, ... }: {
  programs.regreet.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      command = "hyprland --config /home/jr/flakes/modules/hypr/hyprland.conf"
    #   default_session.command = ''
    #     ${pkgs.greetd.regreet}/bin/regreet \
    #       --cmd ${pkgs.hyprland}/bin/Hyprland
    #       # --cmd ${pkgs.sway}/bin/sway
    #   '';
    };
  };

}

