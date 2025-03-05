return {
  'williamboman/mason.nvim',
  optional = true,
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, { 'codelldb' })
    if diagnostics == 'bacon-ls' then
      vim.list_extend(opts.ensure_installed, { 'bacon' })
    end
  end,
}
