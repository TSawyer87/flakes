-- Assuming you have the oil.nvim plugin installed correctly

require('oil').setup({
    float = {
        border = "none",
    },
    keymaps = {
        ["<C-v>"] = "actions.select_split",
        ["q"] = "actions.close",
        ["<C-y>"] = "actions.copy_entry_path",
    },
    view_options = {
        show_hidden = true,
    },
})

-- Open parent directory in current window
vim.keymap.set("n", "-", "<CMD>Oil<CR>")

-- Open parent directory in floating window
vim.keymap.set("n", "<leader>-", require("oil").toggle_float)
