return {
  'akinsho/toggleterm.nvim',
  keys = {
    { '<Leader>tt', desc = 'Toggle terminal' },
    { '<Leader>tf', desc = 'Toggle float terminal' },
  },
  config = function()
    require('toggleterm').setup({})
    vim.keymap.set('n', '<Leader>tt', '<Cmd>ToggleTerm<CR>')
    vim.keymap.set('n', '<Leader>tf', '<Cmd>ToggleTerm direction=float<CR>')
    vim.keymap.set('t', '<Leader>tt', '<C-\\><C-n><Cmd>ToggleTerm<CR>')
    vim.keymap.set('t', '<Leader>tf', '<C-\\><C-n><Cmd>ToggleTerm direction=float<CR>')
  end,
}
