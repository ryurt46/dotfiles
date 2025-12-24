return {
  'Kohirus/cppassist.nvim',
  ft = { 'c', 'cpp', 'cc', 'h', 'hpp' }, -- laddas bara för dessa filtyper
  cmd = { 'CppassistSwitchSourceHeader', 'CppassistGotoHeader' }, -- om du vill köra kommandona direkt
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

