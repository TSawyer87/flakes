{ config, pkgs, ... }:

{
  imports = [ nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;
    # Here you configure your Neovim settings
    options = {
      number = true; # Show line numbers
      relativenumber = true; # Show relative line numbers
    };
    plugins = {
      # Enable plugins
      lualine.enable = true;
    };
    colorschemes = {
      # Set up a colorscheme
      gruvbox.enable = true;
    };
    extraConfigLua = ''
      -- Add custom Lua here for additional configurations
      vim.wo.signcolumn = "yes"
    '';
  };
}
