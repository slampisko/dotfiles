return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose' },
  keys = {
    { '<Leader>gv', desc = 'Toggle diffview' },
  },
  config = function()
    vim.keymap.set('n', '<Leader>gv', function()
      local lib = require('diffview.lib')
      if lib.get_current_view() then
        vim.cmd('DiffviewClose')
      else
        vim.cmd('DiffviewOpen')
      end
    end, { desc = 'Toggle diffview' })
  end,
}
