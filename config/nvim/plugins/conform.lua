require("conform").setup(
  ---@module 'conform'
  {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff" },
      markdown = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      json = { "jq" },
      -- go = { "gofumpt" },
      bash = { "shfmt" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
      -- yml = { "yamlfmt" },
      -- yaml = { "yamlfmt" },
    },

    format_on_save = function(bufnr)
      return {
        timeout_ms = 500,
      }
    end,

    formatters = {
      prettier = {
        prepend_args = { "--tab-width", "4" },
      },
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  }
)
