{
  programs.nixvim = {
    plugins.navic = {
      enable = true;

      settings = {
        lsp = {
          auto_attach = true;
          preference = ["nixd" "shfmt"];
        };
      };
    };
  };
}
