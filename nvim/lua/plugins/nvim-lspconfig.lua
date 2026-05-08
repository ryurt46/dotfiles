return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason.nvim',
      opts = {
        ensure_installed = {
          'clangd',
          'clang-format',
          'codelldb',
        },
      },
    },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())

    -- Build clangd command
    local root = vim.fs.root(0, { 'compile_commands.json', '.git' })
    local clangd_cmd = {
      'clangd',
      '--all-scopes-completion',
      '--background-index',
      '--log=verbose',
      '--enable-config',
      '--clang-tidy',
      '--completion-style=detailed',
      '--offset-encoding=utf-16',
      '--header-insertion=never',
      '--pretty',
      '--query-driver=/usr/bin/g++',
    }

    if root then
      local candidate = root .. '/compile_commands.json'
      local stat = vim.loop.fs_stat(candidate)
      if stat and stat.type == 'file' then
        table.insert(clangd_cmd, '--compile-commands-dir=' .. root)
      end
    end

    -- Configure servers using vim.lsp.config
    vim.lsp.config('clangd', {
      cmd = clangd_cmd,
      root_markers = { 'compile_commands.json', '.git' },
      capabilities = capabilities,
    })

    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = { callSnippet = 'Replace' },
        },
      },
    })

    local simple_servers = { 'jdtls', 'pyright', 'rust_analyzer', 'ts_ls' }
    for _, server in ipairs(simple_servers) do
      vim.lsp.config(server, {
        capabilities = capabilities,
      })
    end

    -- Enable all servers
    vim.lsp.enable { 'clangd', 'lua_ls', 'jdtls', 'pyright', 'rust_analyzer', 'ts_ls' }

    -- Mason tool installer
    require('mason-tool-installer').setup {
      ensure_installed = {
        'clangd',
        'clang-format',
        'codelldb',
        'jdtls',
        'pyright',
        'rust-analyzer',
      },
    }
    require('mason-lspconfig').setup()

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
        end
      end,
    })

    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      },
      virtual_text = { prefix = '■', spacing = 0 },
    }
  end,
}
