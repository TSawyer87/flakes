{
  programs.nixvim = {
    plugins.twilight.enable = true;
    plugins.zen-mode = {
      enable = true;
      luaConfig = ''
            require("zen-mode").setup({
        	plugins = {
        		twilight = { enabled = true },
        	},
        })
      '';
    };
  };
}
