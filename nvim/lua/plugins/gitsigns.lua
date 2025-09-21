return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        -- Vi lägger bara till plugin-specifik setup här, keymaps flyttas till core/keymaps.lua
        require('gitsigns').setup {}
      end,
    },
  },
}
