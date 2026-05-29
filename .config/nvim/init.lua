vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

local keymap = vim.keymap.set
keymap('n', '<Leader>e', ':NvimTreeToggle<CR>')
keymap('n', '<Leader>w', ':write<CR>')
keymap('n', '<Leader>q', ':q<CR>')
keymap('n', '<Leader>h', ':nohlsearch<CR>')
keymap('n', '<Tab>', ':bnext<CR>')
keymap('n', '<S-Tab>', ':bprevious<CR>')
keymap('n', '<C-F4>', ':bd<CR>')
keymap('n', '<A-1>', ':buffer 1<CR>')
keymap('n', '<A-2>', ':buffer 2<CR>')
keymap('n', '<A-3>', ':buffer 3<CR>')
keymap('n', '<A-4>', ':buffer 4<CR>')
keymap('n', '<A-5>', ':buffer 5<CR>')

local nvim_tree_config = {
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}

require('lazy').setup({
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope',
    keys = {
      { '<Leader>ff', desc = 'Find files' },
      { '<Leader>fg', desc = 'Live grep' },
      { '<Leader>fb', desc = 'Buffers' },
      { '<Leader>fh', desc = 'Help' },
    },
    config = function()
      local builtin = require('telescope.builtin')
      keymap('n', '<Leader>ff', builtin.find_files)
      keymap('n', '<Leader>fg', builtin.live_grep)
      keymap('n', '<Leader>fb', builtin.buffers)
      keymap('n', '<Leader>fh', builtin.help_tags)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        ensure_installed = { 'lua', 'vim', 'vimdoc', 'query' },
        auto_install = true,
        highlight = { enable = true },
      })
    end,
  },
  {
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

      keymap('n', 'K', vim.lsp.buf.hover)
      keymap('n', 'gd', vim.lsp.buf.definition)
      keymap('n', 'gD', vim.lsp.buf.declaration)
      keymap('n', 'gi', vim.lsp.buf.implementation)
      keymap('n', 'gr', vim.lsp.buf.references)
      keymap('n', '<Leader>rn', vim.lsp.buf.rename)
      keymap('n', '<Leader>ca', vim.lsp.buf.code_action)
      keymap('n', 'gl', vim.diagnostic.open_float)
      keymap('n', '[d', vim.diagnostic.goto_prev)
      keymap('n', ']d', vim.diagnostic.goto_next)
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        }),
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        keymap('n', '<Leader>gd', function() gs.diffthis('HEAD') end)
        keymap('n', '<Leader>gD', function() gs.diffthis('~') end)
        keymap('n', '<Leader>gb', gs.toggle_current_line_blame)
        keymap('n', '<Leader>gp', gs.preview_hunk_inline)
        keymap('n', '<Leader>gn', gs.next_hunk)
        keymap('n', '<Leader>gN', gs.prev_hunk)
        keymap('n', '<Leader>gs', gs.stage_hunk)
        keymap('n', '<Leader>gu', gs.undo_stage_hunk)
        keymap('n', '<Leader>gr', gs.reset_hunk)
      end,
    },
  },
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'akinsho/toggleterm.nvim',
    keys = {
      { '<Leader>tt', desc = 'Toggle terminal' },
      { '<Leader>tf', desc = 'Toggle float terminal' },
    },
    config = function()
      require('toggleterm').setup({})
      keymap('n', '<Leader>tt', '<Cmd>ToggleTerm<CR>')
      keymap('n', '<Leader>tf', '<Cmd>ToggleTerm direction=float<CR>')
      keymap('t', '<Leader>tt', '<C-\\><C-n><Cmd>ToggleTerm<CR>')
      keymap('t', '<Leader>tf', '<C-\\><C-n><Cmd>ToggleTerm direction=float<CR>')
    end,
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose' },
    keys = {
      { '<Leader>gv', ':DiffviewOpen<CR>', desc = 'Diffview' },
    },
    opts = {},
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('tokyonight')
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup(nvim_tree_config)
    end,
  },
})
