return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      vim.keymap.set('n', '<Leader>gd', function() gs.diffthis('HEAD') end, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>gD', function() gs.diffthis('~') end, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>gb', gs.toggle_current_line_blame, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>gp', gs.preview_hunk_inline, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>gn', gs.next_hunk, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>gN', gs.prev_hunk, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>gs', gs.stage_hunk, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>gu', gs.undo_stage_hunk, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>gr', gs.reset_hunk, { buffer = bufnr })
    end,
  },
}
