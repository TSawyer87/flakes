require("conform").setup(
  ---@module 'conform'
  {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "ruff_format" },
      -- You can customize some of the format options for the filetype (:help conform.format)
      -- Conform will run the first available formatter
      markdown = { "prettierd" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
      nix = { "nixfmt" },
      json = { "jq" },
    },

    format_on_save = function(bufnr)
      return {
        lsp_format = "fallback",
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
