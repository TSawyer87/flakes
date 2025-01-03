{ pkgs, inputs, ... }:
let
  # Build the finecmdline plugin
  finecmdline = pkgs.vimUtils.buildVimPlugin {
    name = "fine-cmdline";
    src = inputs.fine-cmdline;
  };
in {
  programs = {
    neovim = {
      enable = true;
      package =
        pkgs.neovim-nightly-overlay; # This should pick up from the nightly overlay
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        imagemagick
        lua-language-server
        stylua
        gopls
        xclip
        wl-clipboard
        luajitPackages.lua-lsp
        nil
        rust-analyzer
        nodePackages.bash-language-server
        shfmt
        yaml-language-server
        pyright
        marksman
        prettierd
        ruff
        jq
      ];
      plugins = with pkgs.vimPlugins; [
        alpha-nvim
        auto-session
        bufferline-nvim
        dressing-nvim
        indent-blankline-nvim
        nui-nvim
        finecmdline
        nvim-treesitter.withAllGrammars
        lualine-nvim
        nvim-autopairs
        nvim-web-devicons
        nvim-cmp
        nvim-surround
        nvim-lspconfig
        cmp-nvim-lsp
        cmp-buffer
        luasnip
        cmp_luasnip
        friendly-snippets
        lspkind-nvim
        comment-nvim
        nvim-ts-context-commentstring
        plenary-nvim
        neodev-nvim
        luasnip
        telescope-nvim
        todo-comments-nvim
        nvim-tree-lua
        telescope-fzf-native-nvim
        vim-tmux-navigator
        render-markdown-nvim
        markdown-nvim
        hop-nvim
        oil-nvim
        neoscroll-nvim
        twilight-nvim
        zen-mode-nvim
        nvim-ufo
        obsidian-nvim
        conform-nvim
        codeium-nvim
        trouble-nvim
        #flash-nvim
        toggleterm-nvim
        which-key-nvim
        wezterm-nvim
        tokyonight-nvim
        #image-nvim
      ];
      extraConfig = ''
        set noemoji
        nnoremap : <cmd>FineCmdline<CR>
      '';
      extraLuaConfig = ''
        ${builtins.readFile ./nvim/options.lua}
        ${builtins.readFile ./nvim/keymaps.lua}
        ${builtins.readFile ./nvim/autocmds.lua}
        ${builtins.readFile ./nvim/plugins/alpha.lua}
        ${builtins.readFile ./nvim/plugins/autopairs.lua}
        ${builtins.readFile ./nvim/plugins/auto-session.lua}
        ${builtins.readFile ./nvim/plugins/comment.lua}
        ${builtins.readFile ./nvim/plugins/cmp.lua}
        ${builtins.readFile ./nvim/plugins/lsp.lua}
        ${builtins.readFile ./nvim/plugins/nvim-tree.lua}
        ${builtins.readFile ./nvim/plugins/telescope.lua}
        ${builtins.readFile ./nvim/plugins/todo-comments.lua}
        ${builtins.readFile ./nvim/plugins/treesitter.lua}
        ${builtins.readFile ./nvim/plugins/fine-cmdline.lua}
        ${builtins.readFile ./nvim/plugins/markdown.lua}
        ${builtins.readFile ./nvim/plugins/hop.lua}
        ${builtins.readFile ./nvim/plugins/oil.lua}
        ${builtins.readFile ./nvim/plugins/neoscroll.lua}
        ${builtins.readFile ./nvim/plugins/twilight.lua}
        ${builtins.readFile ./nvim/plugins/zen-mode.lua}
        ${builtins.readFile ./nvim/plugins/obsidian.lua}
        ${builtins.readFile ./nvim/plugins/conform.lua}
        ${builtins.readFile ./nvim/plugins/codeium.lua}
        ${builtins.readFile ./nvim/plugins/trouble.lua}
        ${builtins.readFile ./nvim/plugins/ufo.lua}
        ${builtins.readFile ./nvim/plugins/toggleterm.lua}
        ${builtins.readFile ./nvim/plugins/lualine.lua}
        ${builtins.readFile ./nvim/plugins/which-key.lua}
        ${builtins.readFile ./.stylua.toml}
        require("wezterm").setup{}
        require("render-markdown").setup{}
        require("ibl").setup()
        require("bufferline").setup{}
      '';
    };
  };
}
