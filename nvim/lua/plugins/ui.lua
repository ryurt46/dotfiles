return {
  { -- Lualine
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'powerline',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { statusline = {}, winbar = {} },
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          {
            'diff',
            colored = true,
            diff_color = {
              added = { fg = '#094f06' },
              modified = { fg = '#eba534' },
              removed = { fg = '#e01010' },
            },
          },
        },
        lualine_c = { 'filename' },
        lualine_x = { { function() return vim.bo.fileformat end }, 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { function()
          local l, c = vim.fn.line('.'), vim.fn.col('.')
          return string.format('%d:%d', l, c)
        end, 'diagnostics' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
    },
  },

  -- Lazy.nvim UI icons
  { -- icons config for lazy.nvim
    'folke/lazy.nvim',
    opts = {
      ui = {
        icons = vim.g.have_nerd_font and {} or {
          cmd = '⌘',
          config = '🛠',
          event = '📅',
          ft = '📂',
          init = '⚙',
          keys = '🗝',
          plugin = '🔌',
          runtime = '💻',
          require = '🌙',
          source = '📄',
          start = '🚀',
          task = '📌',
          lazy = '💤 ',
        },
      },
    },
  },
}
