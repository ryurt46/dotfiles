return {
  'tpope/vim-fugitive',
  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    keymap.set('n', '<leader>gist', '<cmd>Git status<cr>', { desc = 'git status' })
    keymap.set('n', '<leader>gip', '<cmd>Git push<cr>', { desc = 'git push' })
    keymap.set('n', '<leader>gif', '<cmd>Git fetch<cr>', { desc = 'git fetch' })
    keymap.set('n', '<leader>girb', '<cmd>Git rebase<cr>', { desc = 'git rebase' })
    keymap.set('n', '<leader>gibl', '<cmd>Git blame<cr>', { desc = 'git blame' })
  end,
}
