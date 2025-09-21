return {
  'nvimtools/none-ls.nvim',
  event = 'VeryLazy',
  config = function()
    local null_ls = require 'null-ls'
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    local cfg = os.getenv 'HOME' .. '/.config/clang-format/'

    local function clang_format_args()
      local root = vim.fn.getcwd()
      local found = vim.fn.glob(root .. '/.clang-format')

      if found ~= '' then
        return { '--style=file' }
      else
        return {
          '--style',
          '{BasedOnStyle: LLVM, BreakBeforeBraces: Attach, '
          .. 'IndentWidth: 4, TabWidth: 4, UseTab: Never, ColumnLimit: 100, '
          .. 'IndentAccessModifiers: false, AccessModifierOffset: -4, '
          .. 'AllowShortFunctionsOnASingleLine: Empty, '
          .. 'BraceWrapping: {SplitEmptyFunction: false}, '
          .. 'PointerAlignment: Left}',
          --[[
            -- Linux config:
            extra_args = {
              '--style=file',
              '--assume-filename=' .. cfg .. 'torvalds/dummy.cpp', -- Torvalds
            },
            --]]
        }
      end
    end

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.clang_format.with {
          extra_args = clang_format_args,
        },
      },
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
              if ft ~= "erlang" then
                vim.lsp.buf.format { bufnr = bufnr }
              end
            end,
          })
        end
      end,
    }
  end,
}
