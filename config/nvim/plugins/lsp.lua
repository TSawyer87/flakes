local lspconfig = require("lspconfig")

lspconfig.pyright.setup({})
lspconfig.nil_ls.setup({
  autostart = true,
  settings = {
    ["nil"] = {
      testSetting = 42,
      formatting = {
        command = { "nixfmt" },
      },
      nix = {
        flake = {
          autoArchive = true,
        },
      },
    },
  },
})
lspconfig.lua_ls.setup({
  -- cmd = { ... },
  -- filetypes = { ... },
  -- capabilities = {},
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
})
lspconfig.marksman.setup({})
lspconfig.markdown_oxide.setup({})
-- lspconfig.rust_analyzer.setup({})
lspconfig.yamlls.setup({})
lspconfig.bashls.setup({})
lspconfig.hyprls.setup({})
