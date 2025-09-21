return {
  'p00f/clangd_extensions.nvim',
  ft = { 'c', 'cc', 'cpp', 'objc', 'objcpp', 'cuda' },
  config = function()
    require('clangd_extensions').setup {
      inlay_hints = {
        only_current_line = true,
        only_current_line_autocmd = { 'CursorHold' },
      },
    }
  end,
}
