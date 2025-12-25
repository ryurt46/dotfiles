local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- senaste stabila releasen
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require 'core.options'
require 'core.keymaps'
require 'core.snippets'
require 'core.ui'

require('lazy').setup {
  defaults = { lazy = true },

  'tpope/vim-sleuth',
  'NMAC427/guess-indent.nvim',

  { import = 'plugins.autopairs' },
  { import = 'plugins.gitsigns' },
  { import = 'plugins.color' },
  { import = 'plugins.ui' },
  { import = 'plugins.lualine' },
  { import = 'plugins.mini' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.telescope' },
  { import = 'plugins.todo' },
  { import = 'plugins.formatters' },
  -- { import = 'plugins.indent_line' },
  { import = 'plugins.fugitive' },
  { import = 'plugins.neo-tree' },
  { import = 'plugins.nvim-cmp' },
  { import = 'plugins.nvim-lspconfig' },
  -- { import = 'plugins.nvim-dap' },
  { import = 'plugins.jdtls' },
  { import = 'plugins.cppassist' },
  { import = 'plugins.clangd_extensions' },
  -- { import = 'plugins.lint' },
  -- { import = 'plugins.go' },
  { import = 'plugins.none-ls' },
  { import = 'plugins.web-devicons' },
  { import = 'plugins.dashboard' },
  { import = 'plugins.which-key' },
  { import = 'plugins.lazydev' },
  { import = 'plugins.debug' },
  { import = 'plugins.barbar' },
  { import = 'plugins.git' },
  { import = 'plugins.neogit' },
  { import = 'plugins.gdb' },
  { import = 'plugins.sleuth' },
}
