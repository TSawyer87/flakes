{ inputs, pkgs, system, ... }: {
  programs.nvf = {
  vim.package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = { enable = true; };
    };
  };
}
