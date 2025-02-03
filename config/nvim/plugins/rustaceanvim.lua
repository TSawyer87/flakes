-- nvim/plugins/rustaceanvim.lua
require("packer").use({
  "mrcjkb/rustaceanvim",
  version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
  ft = { "rust" },
  config = function()
    local opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>cR", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })
        end,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = { enable = true },
            },
            checkOnSave = true,
            diagnostics = { enable = true },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
            },
          },
        },
      },
    }
    vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts)

    if vim.fn.executable("rust-analyzer") == 0 then
      print("**rust-analyzer** not found in PATH. Please install it.")
    end

    local codelldb_path = vim.fn.globpath(
      vim.fn.stdpath("data") .. "/mason/packages/codelldb/*/extension/adapter/codelldb",
      1
    )[1]
    if codelldb_path ~= "" then
      local lldb_lib_path = vim.fn.globpath(
        vim.fn.stdpath("data") .. "/mason/packages/codelldb/*/extension/lldb/lib/*lldb*",
        1
      )[1]
      if lldb_lib_path ~= "" then
        opts.dap = {
          adapter = require("rustaceanvim.config").get_codelldb_adapter(
            codelldb_path,
            lldb_lib_path
          ),
        }
      else
        print("codelldb's lldb library not found. Debugging might not work.")
      end
    else
      print("codelldb not found. Install it with Mason for debugging support.")
    end
  end,
})
