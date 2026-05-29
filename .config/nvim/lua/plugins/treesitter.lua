return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup({
      ensure_installed = { 'lua', 'vim', 'vimdoc', 'query' },
      auto_install = true,
      highlight = { enable = true },
    })
  end,
}
