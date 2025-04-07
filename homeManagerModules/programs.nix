{pkgs, ...}: {
  programs = {
    home-manager.enable = true;
    gh.enable = true;
    btop = {
      enable = true;
      settings = {vim_keys = true;};
    };

    zathura = {enable = true;};

    go = {enable = true;};

    # nix-index = { enable = true; }; # nix-locate
  };
}
