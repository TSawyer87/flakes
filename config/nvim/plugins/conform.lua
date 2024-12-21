require("conform").setup({
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "ruff_format" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    -- Conform will run the first available formatter
    markdown = { "prettierd" },
    bash = { "shfmt" },
    nix = { "nixfmt" },
    json = { "jq" },
  },
})
