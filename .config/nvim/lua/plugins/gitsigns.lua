return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      vim.keymap.set('n', '<Leader>gd', function() gs.diffthis('HEAD') end, { buffer = bufnr, desc = 'Git diff HEAD' })
      vim.keymap.set('n', '<Leader>gD', function() gs.diffthis('~') end, { buffer = bufnr, desc = 'Git diff HEAD~1' })
      vim.keymap.set('n', '<Leader>gb', gs.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle blame' })
      vim.keymap.set('n', '<Leader>gp', gs.preview_hunk_inline, { buffer = bufnr, desc = 'Preview hunk' })
      vim.keymap.set('n', '<Leader>gn', gs.next_hunk, { buffer = bufnr, desc = 'Next hunk' })
      vim.keymap.set('n', '<Leader>gN', gs.prev_hunk, { buffer = bufnr, desc = 'Previous hunk' })
      vim.keymap.set('n', '<Leader>gs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
      vim.keymap.set('n', '<Leader>gu', gs.undo_stage_hunk, { buffer = bufnr, desc = 'Undo stage hunk' })
      vim.keymap.set('n', '<Leader>gr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
    end,
  },
}
