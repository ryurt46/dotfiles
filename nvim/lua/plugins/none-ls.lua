return {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' }, -- trigga vid filöppning
  config = function()
    local null_ls = require 'null-ls'

    -- Look for .clang-format in project root
    local function find_clang_format()
      local dir = vim.fn.expand '%:p:h'
      while dir ~= '/' do
        local file = dir .. '/.clang-format'
        if vim.fn.filereadable(file) == 1 then
          return file
        end
        dir = vim.fn.fnamemodify(dir, ':h')
      end
      return nil
    end

    -- Extra args to clang-format
    local function clang_format_args()
      if find_clang_format() then
        return { '--style=file' }
      else
        return {
          '--style',
          [[{
          BreakBeforeBraces: Allman,
          IndentWidth: 4,
          TabWidth: 4,
          UseTab: Never,
          ColumnLimit: 0,
          ReflowComments: false,
          AllowShortFunctionsOnASingleLine: false,
          PointerAlignment: Left,
          SpaceBeforeParens: ControlStatements,
          SpacesInParentheses: false,
          IndentCaseLabels: true,
          BraceWrapping: {
            AfterClass: true,
            AfterControlStatement: true,
            AfterEnum: true,
            AfterFunction: true,
            AfterNamespace: true,
            AfterStruct: true,
            AfterUnion: true,
            BeforeCatch: true,
            BeforeElse: true,
            SplitEmptyFunction: false,
            SplitEmptyRecord: false,
            SplitEmptyNamespace: false
          }
        }]],
        }
      end
    end

    -- Setup null-ls / none-ls
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.clang_format.with {
          extra_args = clang_format_args,
          to_stdin = true,
        },
      },
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          -- Keymap: format entire buffer
          vim.keymap.set('n', '<leader>cf', function()
            vim.lsp.buf.format { bufnr = bufnr, async = true }
          end, { buffer = bufnr, desc = 'Format with clang-format' })

          -- Keymap: format visual
          vim.keymap.set('v', '<leader>cf', function()
            vim.lsp.buf.range_formatting({}, vim.fn.getpos "'<", vim.fn.getpos "'>")
          end, { buffer = bufnr, desc = 'Format selection with clang-format' })

          -- Auto-format on save
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { bufnr = bufnr, async = false }
            end,
          })
        end
      end,
    }
  end,
}
