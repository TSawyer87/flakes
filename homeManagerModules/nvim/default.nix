{
  pkgs,
  inputs,
  ...
}: let
  pinnedPkgs =
    import
    (pkgs.fetchFromGithub {
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "fa35a3c8e17a3de613240fea68f876e5b4896aec";
      sha256 = "sha256-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX="; # Compute this
    })
    {config.allowUnfree = true;};
in {
  programs = {
    neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      # defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      # withNodeJs = true;
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
        markdown-oxide
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
        flash-nvim
        toggleterm-nvim
        which-key-nvim
        tokyonight-nvim
        rustaceanvim
        crates-nvim
        hunk-nvim
        yazi-nvim
        #image-nvim
      ];
      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
        ${builtins.readFile ./keymaps.lua}
        ${builtins.readFile ./autocmds.lua}
        ${builtins.readFile ./plugins/alpha.lua}
        ${builtins.readFile ./plugins/autopairs.lua}
        ${builtins.readFile ./plugins/auto-session.lua}
        ${builtins.readFile ./plugins/comment.lua}
        ${builtins.readFile ./plugins/cmp.lua}
        ${builtins.readFile ./plugins/lsp.lua}
        ${builtins.readFile ./plugins/nvim-tree.lua}
        ${builtins.readFile ./plugins/telescope.lua}
        ${builtins.readFile ./plugins/todo-comments.lua}
        ${builtins.readFile ./plugins/treesitter.lua}
        ${builtins.readFile ./plugins/markdown.lua}
        ${builtins.readFile ./plugins/hop.lua}
        ${builtins.readFile ./plugins/oil.lua}
        ${builtins.readFile ./plugins/neoscroll.lua}
        ${builtins.readFile ./plugins/twilight.lua}
        ${builtins.readFile ./plugins/zen-mode.lua}
        ${builtins.readFile ./plugins/obsidian.lua}
        ${builtins.readFile ./plugins/conform.lua}
        ${builtins.readFile ./plugins/trouble.lua}
        ${builtins.readFile ./plugins/ufo.lua}
        ${builtins.readFile ./plugins/toggleterm.lua}
        ${builtins.readFile ./plugins/lualine.lua}
        ${builtins.readFile ./plugins/which-key.lua}
        ${builtins.readFile ./plugins/flash.lua}
        ${builtins.readFile ./plugins/crates.lua}
        ${builtins.readFile ./plugins/hunk.lua}
        ${builtins.readFile ./plugins/yazi.lua}
        ${builtins.readFile ./plugins/codeium.lua}
        ${builtins.readFile ./plugins/rustaceanvim.lua}
        ${builtins.readFile ./.stylua.toml}
        require("render-markdown").setup{}
        require("ibl").setup()
        require("bufferline").setup{}
        require('hunk').setup{}
        vim.lsp.inlay_hint.enable()
      '';
    };
  };
  nixpkgs.config.allowUnfree = true;
}
