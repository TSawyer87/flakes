local wk = require("which-key")
wk.add({
  { "<leader>f", group = "[F]ind Files" }, -- group
  { "<leader>s", group = "[S]plits" }, -- group
  { "<leader>z", group = "[Z]enMode + [F]olds" }, -- group
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers", mode = "n" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help", mode = "n" },
  { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos", mode = "n" },
  { "<leader>lg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep", mode = "n" },
  { "<leader>sv", "<C-w>v", desc = "Split Window Vertically", mode = "n" },
  { "<leader>sh", "<C-w>s", desc = "Split Window Horizontally", mode = "n" },
  { "<leader>zR", "<cmd>lua require('ufo').openAllFolds<cr>", desc = "Open Folds", mode = "n" },
  { "<leader>zM", "<cmd>lua require('ufo').closeAllFolds<cr>", desc = "Close Folds", mode = "n" },
  { "<leader>zm", "<cmd>ZenMode<cr>", desc = "ZenMode", mode = "n" },
  {
    "<leader>fb",
    function()
      print("hello")
    end,
    desc = "Foobar",
  },
  { "<leader>fn", desc = "New File" },
  { "<leader>f1", hidden = true }, -- hide this keymap
  { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
  {
    "<leader>b",
    group = "buffers",
    expand = function()
      return require("which-key.extras").expand.buf()
    end,
  },
  {
    -- Nested mappings are allowed and can be added in any order
    -- Most attributes can be inherited or overridden on any level
    -- There's no limit to the depth of nesting
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  },
})
