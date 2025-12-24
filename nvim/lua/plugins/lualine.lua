return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'powerline',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = true,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
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
        lualine_x = {
          function()
            return vim.bo.fileformat
          end,
          'encoding',
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = {
          function()
            local col = vim.fn.col '.'
            local line = vim.fn.line '.'
            local total = vim.fn.line '$'
            return string.format('%d:%d:%d', col, line, total)
          end,
          'diagnostics',
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
