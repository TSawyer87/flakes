{ pkgs, ... }: {
  programs.regreet.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.regreet}/bin/regreet \
          --time \
          --asterisks \
          --user-menu \
          # --cmd ${pkgs.sway}/bin/sway
          --cmd ${pkgs.hyprland}/bin/Hyprland
          # "${lib.getExe config.programs.hyprland.package} --config "
           # --cmd uwsm start hyprland.desktop
           # -- cmd {inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/Hyprland
      '';
    };
  };

}

