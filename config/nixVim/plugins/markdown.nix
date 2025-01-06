{ pkgs, ... }: {
  programs.nixvim = {
    plugins = {
      markdown-nvim = {
        enable = true;
        package = pkgs.vimPlugins.markdown-nvim;
      };
    };
  };
}
