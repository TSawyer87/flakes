{ pkgs, ... }: {
  programs.nixvim = {
    plugins = {
      markdown-nvim.enable = true;
      markdown.package = pkgs.vimPlugins.markdown-nvim;
    };
  };
}
