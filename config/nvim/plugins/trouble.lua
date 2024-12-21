local trouble = require("trouble")
trouble.setup({})

local keymap = vim.keymap

keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle Trouble" })
keymap.set(
  "n",
  "<leader>xb",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Buffer Diagnostics (Trouble)" }
)
keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble Quickfix" })
keymap.set(
  "n",
  "<leader>xl",
  "<cmd>Trouble loclist toggle<cr>",
  { desc = "Toggle Trouble Loclist" }
)
keymap.set(
  "n",
  "<leader>xR",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "Trouble LSP References" }
)
