{ pkgs, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          # --cmd ${pkgs.sway}/bin/sway
          --cmd ${pkgs.hyprland}/bin/hyprland
      '';
    };
  };

}

