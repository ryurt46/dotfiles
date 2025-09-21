-- GitSigns highlights
vim.cmd [[
  hi GitSignsAdd       guifg=#00ff00 guibg=#003300
  hi GitSignsAddInline guifg=#00ff00 guibg=#003300
  hi GitSignsChange       guifg=#ffff00 guibg=#333300
  hi GitSignsChangeInline guifg=#ffff00 guibg=#333300
  hi GitSignsDelete       guifg=#ff0000 guibg=#330000
  hi GitSignsDeleteInline guifg=#ff0000 guibg=#330000
]]

-- Fullscreen background escape sequences
vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if normal.bg then
      io.write(string.format('\027]11;#%06x\027\\', normal.bg))
    end
  end,
})
vim.api.nvim_create_autocmd('UILeave', {
  callback = function() io.write '\027]111\027\\' end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})
