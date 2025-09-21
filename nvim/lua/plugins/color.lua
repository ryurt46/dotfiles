-- lua/plugins/colors.lua
return {
  ----- MOLOKAI
  --[[
  {
    'tomasr/molokai',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'molokai'
    end,
  },
  ]]

  ----- ONE DARK
  --[[
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
  ]]

  --- VSCODE DARK (aktivt tema)
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'vscode'
    end,
  },

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
  ]]

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
}
