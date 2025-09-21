return {
  'Kohirus/cppassist.nvim',
  lazy = false, -- ladda direkt
  config = function()
    require('cppassist').setup {
      switch_sh = {
        include_dirs = { '.', '..' },
        exclude_dirs = {},
        search_flags = '-tf -s -L',
        return_type = {
          int = '0',
          short = '0',
          long = '0',
          char = '0',
          double = '0.0',
          float = '0.0',
          bool = 'false',
          pointer = 'nullptr',
        },
      },
      goto_header = {
        include_dirs = { '.', '..', '/usr/include', '/usr/local/include', '~' },
        exclude_dirs = {},
        search_flags = '-tf -s',
      },
    }
  end,
}
