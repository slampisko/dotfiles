return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = { 'hrsh7th/cmp-nvim-lsp' },
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local servers = { 'ts_ls', 'html', 'cssls', 'pylsp' }
    for _, server in ipairs(servers) do
      vim.lsp.config(server, { capabilities = capabilities })
      vim.lsp.enable(server)
    end
  end,
}
