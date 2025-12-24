return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      },
      on_attach = function(bufnr)
        -- nya rader (grön)
        vim.cmd 'hi GitSignsAdd guifg=#00ff00 guibg=NONE'
        -- borttagna rader (röd)
        vim.cmd 'hi GitSignsDelete guifg=#ff0000 guibg=NONE'
        -- ändrade rader (orange)
        vim.cmd 'hi GitSignsChange guifg=#ff9900 guibg=NONE'
      end,
    },
  },
}
