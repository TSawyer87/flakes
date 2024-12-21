require("markdown").setup({
      on_attach = function(bufnr)
        local function toggle(key)
          return "<Esc>gv<Cmd>lua require'markdown.inline'"
            .. ".toggle_emphasis_visual'"
            .. key
            .. "'<CR>"
        end

        vim.keymap.set("x", "<C-b>", toggle("b"), { buffer = bufnr })
        vim.keymap.set("x", "<C-i>", toggle("i"), { buffer = bufnr })
        vim.keymap.set("x", "<C-c>", toggle("c"), { buffer = bufnr })
        vim.keymap.set("x", "<C-t>", toggle("s"), { buffer = bufnr })
      end,
    })
