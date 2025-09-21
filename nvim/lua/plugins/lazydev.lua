return {
  'folke/lazydev.nvim',
  ft = 'lua', -- lazy-load endast för Lua-filer
  opts = {
    library = {
      -- Laddar luvit-typer när `vim.uv` används
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  },
}
