{ pkgs, lib, ... }: {
  programs.nvf = {
    enable = true;
    settings = {
      vim.viAlias = true;
      vim.vimAlias = false;
      vim.lsp = { enable = true; };
    };
  };
}
