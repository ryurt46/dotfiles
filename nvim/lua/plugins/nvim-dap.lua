return {
  -- Mason integration for DAP
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap' },
    opts = { handlers = {} }, -- kan utökas för specifika DAP-handlers
  },

  -- Core nvim-dap
  {
    'mfussenegger/nvim-dap',
    event = 'InsertEnter',
    dependencies = {
      -- Python adapter
      {
        'mfussenegger/nvim-dap-python',
        config = function()
          local python_path = vim.fn.exepath 'python3'
          require('dap-python').setup(python_path)
        end,
      },

      -- DAP UI
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' },
        config = function()
          require('dapui').setup()
        end,
      },

      -- Virtual text for DAP
      {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
          require('nvim-dap-virtual-text').setup()
        end,
      },
    },
  },

  -- C/C++ DAP via codelldb
  {
    'rcarriga/nvim-dap', -- codelldb använder nvim-dap
    config = function()
      local dap = require 'dap'
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = 'codelldb',
          args = { '--port', '${port}' },
        },
      }

      dap.configurations.cpp = {
        {
          name = 'Launch file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      -- C och Rust kan dela samma konfiguration som C++
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
}
