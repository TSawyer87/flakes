require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "tokyonight",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    -- Add the LSP server name to lualine_x
    lualine_x = {
      {
        function()
          -- Get the list of active LSP clients
          local clients = vim.lsp.get_active_clients({ bufnr = 0 })
          -- If there are no clients, return an empty string
          if next(clients) == nil then
            return ""
          end

          -- Otherwise, concatenate all client names
          local client_names = {}
          for _, client in pairs(clients) do
            table.insert(client_names, client.name)
          end
          return " " .. table.concat(client_names, ", ") -- " " is just an icon for LSP
        end,
        -- Config for the component
        icon = " LSP:", -- If you want an icon in front of the LSP name
        color = { fg = "#ffffff", gui = "bold" }, -- Example color, adjust as needed
      },
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
