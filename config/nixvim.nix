{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    # Here you configure your Neovim settings
    options = {
      number = true; # Show line numbers
      relativenumber = true; # Show relative line numbers
      colorcolumn = "80";
    };
    plugins = {
      # Enable plugins
      lualine.enable = true;
    };
    colorschemes.catppuccin.enable = true;
    extraConfigLua = ''
      -- Add custom Lua here for additional configurations
      vim.wo.signcolumn = "yes"
    '';
  };
}
