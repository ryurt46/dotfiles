return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'VeryLazy',
  opts = {
    enable = true,

    -- Maximalt antal rader som context får ta upp
    max_lines = 3,

    -- Visa context baserat på markörens position
    mode = 'cursor',

    -- Ta bort yttre scopes först om det blir för många
    trim_scope = 'outer',

    multiline_threshold = 20,
  },
}
