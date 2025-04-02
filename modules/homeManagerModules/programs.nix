{ pkgs, ... }: {
  programs = {
    home-manager.enable = true;
    # nh = {
    #   enable = true;
    #   clean.enable = true;
    #   clean.extraArgs = "--keep-since 4d --keep 3";
    #   flake = "/home/jr/flakes";
    # };

    bat.enable = true;
    gh.enable = true;
    btop = {
      enable = true;
      settings = { vim_keys = true; };
    };

    zathura = { enable = true; };

    go = { enable = true; };

    # nix-index = { enable = true; }; # nix-locate
  };
}
