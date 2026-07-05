-- lua/plugins/colors.lua
return {
  -- MOLOKAI BLACK BG
  --[[
  {
    'tomasr/molokai',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'molokai'

      -- Tvinga svart bakgrund
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'black' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'black' })
      vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'black' })
      vim.api.nvim_set_hl(0, 'LineNr', { bg = 'black' })
      vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'black' })
      -- Ljusa upp radnummer
      vim.api.nvim_set_hl(0, 'LineNr', { fg = '#7f7f7f', bg = 'black' })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#e6db74', bg = 'black', bold = true })
      vim.api.nvim_set_hl(0, 'MatchParen', {
        fg = 'NONE',
        bg = '#3a3a3a',
        bold = true,
      })
    end,
  },
 ]]
  {
    'ownself/dracula-colorful.nvim',
    priority = 1000,
    init = function()
      require('dracula-colorful').setup {
        transparent_background = false,
        dim_inactive = false,
        styles = {
          comments = { 'italic' },
          keywords = {},
          functions = {},
          parameters = {},
          fields = {},
          types = {},
        },
        integrations = {
          cmp = true,
          blink = true,
          gitsigns = true,
          rainbow_delimiters = true,
          nvimtree = true,
        },
      }
      vim.cmd.colorscheme 'dracula-colorful'
    end,
  },

  --[[
  {
    -- add dracula
    'binhtran432k/dracula.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'dracula'
    end,
  },
  ----- MOLOKAI
  {
    'tomasr/molokai',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'molokai'
    end,
  },

  {
    'navarasu/onedark.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'deep',
        term_colors = true,
      }
      -- Enable theme
      require('onedark').load()
    end,
  },
     ]]

  --[[
  ----- ONE DARK
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
]]
  ---- ROSE PINE
  --[[
  {
    "rose-pine/neovim",
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
  ]]

  --[[ DRACULA
  {
    'Mofiqul/dracula.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'dracula'
    end,
  },
  

  --- VSCODE DARK (aktivt tema)
  --[[
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'vscode'
    end,
  },
    ]]
  --- HEMISU
  --[[
  {
    'noahfrederick/vim-hemisu',
    priority = 1000,
    init = function()
      vim.opt.background = 'dark'
      vim.cmd.colorscheme 'hemisu'
    end,
  },

  --[[
  {
    'tomasiser/vim-code-dark',
    priority = 1000,
    init = function()
      vim.opt.background = 'dark'
      vim.cmd.colorscheme 'codedark'
    end,
  },
  ]]
  --[[
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
      ]]
}
