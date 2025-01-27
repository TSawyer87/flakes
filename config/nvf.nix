{ inputs, pkgs, system, ... }: {
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim.package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      vim.viAlias = true;
      vim.vimAlias = false;
      vim.lsp = { enable = true; };
      vim.languages.nix.enable = true;
    };
  }
