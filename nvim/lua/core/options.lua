-- lua/core/options.lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = false
vim.opt.scrolloff = 10
vim.opt.showtabline = 0
vim.opt.background = 'dark'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.g.barbar_auto_setup = false
-- vim.o.shiftwidth = 4   -- antal spaces per indent
-- vim.o.tabstop = 4      -- tabbar motsvarar 4 spaces
-- vim.o.softtabstop = 4  -- styr backspace/tabb i insert mode
--  vim.o.expandtab = true  -- använd spaces istället för tabs

-- Dont move cursor on :w
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.b.view = vim.fn.winsaveview()
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function()
    if vim.b.view then
      vim.fn.winrestview(vim.b.view)
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 't', 'c', 'r', 'o', 'q' }
    vim.opt_local.textwidth = 0
  end,
})
