require("flash").setup(
  ---@module 'flash'
  {
    jump = {
      autojump = true,
    },
    keys = {
      {
        "<LEADER>v",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<LEADER>V",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
    },
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
  }
)
