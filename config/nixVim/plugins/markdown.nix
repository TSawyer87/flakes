{ pkgs, ... }: {
  programs.nixvim = {
    plugins = {
      markdown-nvim.enable = true;
      markdown-nvim.package = pkgs.vimPlugins.markdown-nvim;
    };
  };
}
