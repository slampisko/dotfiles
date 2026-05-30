return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    spec = {
      { '<Leader>g', group = 'Git' },
      { '<Leader>gv', desc = 'Toggle diffview', mode = 'n' },
    },
  },
}
