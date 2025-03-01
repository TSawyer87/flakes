{ username, ... }: {
  # Place Files Inside Home Directory
  home.file."Pictures/Wallpapers" = {
    source = ../../config/wallpapers;
    recursive = true;
  };
  home.file.".config/wlogout/icons" = {
    source = ../../config/wlogout;
    recursive = true;
  };
  home.file.".config/hypr/pyprland.toml" = {
    source = ../../config/hypr/pyprland.toml;
    recursive = true;
  };
  home.file.".config/nvim/after/ftplugin/rust.lua".text = ''
        local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set(
      "n", 
      "<leader>a", 
      function()
        vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
        -- or vim.lsp.buf.codeAction() if you don't want grouping.
      end,
      { silent = true, buffer = bufnr }
    )
    vim.keymap.set(
      "n", 
      "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
      function()
        vim.cmd.RustLsp({'hover', 'actions'})
      end,
      { silent = true, buffer = bufnr }
    )
  '';
  home.file.".jj/config.toml".text = ''
    [ui]
    diff-editor = ["nvim", "-c", "DiffEditor $left $right $output"]
  '';

  # home.file.".face.icon".source = ../../config/face.jpg;
  # home.file.".config/face.jpg".source = ../../config/face.jpg;
  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=/home/${username}/Pictures/Screenshots
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=Ubuntu
    paint_mode=brush
    early_exit=true
    fill_shape=false
  '';

  # home.file.".config/wpaperd/config.toml".text = ''
  #       [default]
  #   path = "/home/jr/Pictures/Wallpapers/"
  #   duration = "1h"
  #   transition-time = 600
  #
  # '';
}
