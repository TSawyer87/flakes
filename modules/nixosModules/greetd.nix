{ pkgs, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.gtkgreet}/bin/gtkgreet \
          --time \
          --asterisks \
          --user-menu \
          # --cmd ${pkgs.sway}/bin/sway
          --cmd ${pkgs.hyprland}/bin/Hyprland
           # --cmd uwsm start hyprland.desktop
           # -- cmd {inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/Hyprland
      '';
    };
  };

}

