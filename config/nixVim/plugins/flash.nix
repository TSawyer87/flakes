{
  programs.nixvim = {
    plugins.flash = {
      enable = true;
      settings = {
        modes = {char = {jump_labels = true;};};
        search = {
          exclude = [
            "notify"
            "cmp_menu"
            "noice"
            "flash_prompt"
            # "NeogitStatus"
            {
              __raw = ''
                function(win)
                  -- exclude non-focusable windows
                  return not vim.api.nvim_win_get_config(win).focusable
                end
              '';
            }
          ];
        };
      };
    };
  };
}
