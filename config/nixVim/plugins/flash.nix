{ pkgs, ... }: {
  programs.nixvim = {
    plugins.flash = {
      package = pkgs.vimPlugins.flash-nvim;
      enable = true;
      autoLoad = true;
    };
  };
}
