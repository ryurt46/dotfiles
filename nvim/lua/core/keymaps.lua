local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move line up and dowwn
map("n", "<A-j>", ":m .+1<CR>==", opts) -- move line up(n)
map("n", "<A-k>", ":m .-2<CR>==", opts) -- move line down(n)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts) -- move line up(v)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts) -- move line down(v)

-- GitSigns
map('n', '<A-å>', ':Gitsigns toggle_current_line_blame<CR>', opts)
map('n', '<A-ä>', ':Gitsigns blame<CR>', opts)
map('n', '<A-ö>', ':Gitsigns preview_hunk_inline<CR>', opts)

-- Buffer navigation
map('n', '<A-.>', ':BufferNext<CR>', opts)
map('n', '<A-,>', ':BufferPrevious<CR>', opts)
map('n', '<A-m>', ':BufferClose<CR>', opts)
map('n', '<M-d>', ':BufferClose<CR>', opts)

-- Toggle barbar visibility
map('n', '<A-->', ':lua vim.opt.showtabline = (vim.opt.showtabline:get() == 2 and 0 or 2)<CR>', opts)

-- Diagnostics toggle
local diagnostics_hidden = false
local function toggle_diagnostics()
  diagnostics_hidden = not diagnostics_hidden
  if diagnostics_hidden then
    vim.diagnostic.hide()
  else
    vim.diagnostic.show()
  end
end

-- Keymaps
vim.keymap.set('n', '<F3>', toggle_diagnostics, { desc = 'Toggle diagnostics' })
vim.keymap.set('n', '<A-F3>', toggle_diagnostics, { desc = 'Toggle diagnostics (AltGr)' })
map('n', '<F2>', ':lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', '<leader>q', ':lua vim.diagnostic.setloclist()<CR>', opts)

-- Terminal exit
map('t', '<Esc><Esc>', '<C-\\><C-n>', opts)

-- Split navigation
map('n', '<C-h>', '<C-w><C-h>', opts)
map('n', '<C-l>', '<C-w><C-l>', opts)
map('n', '<C-j>', '<C-w><C-j>', opts)
map('n', '<C-k>', '<C-w><C-k>', opts)

-- C++ helpers
map('n', '<leader>ch', ':SwitchSourceAndHeader<CR>', opts)
map('n', '<leader>ci', ':ImplementInSource<CR>', opts)
map('n', '<leader>co', ':ImplementOutOfClass<CR>', opts)
map('n', '<leader>gh', ':GotoHeaderFile<CR>', opts)
map('v', '<leader>ci', ':lua require("cppassist").ImplementInSourceInVisualMode()<CR>', opts)

-- Clear highlights on search
map('n', '<Esc>', ':nohlsearch<CR>', opts)

-- NvimTree toggle
map('n', '<C-n>', ':NvimTreeToggle<CR>', opts)

-- Move selected text up/down in visual mode
map('x', 'J', ":move '>+1<CR>gv=gv", opts)
map('x', 'K', ":move '<-2<CR>gv=gv", opts)

-- GitSigns buffer-local keymaps
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local gs = require('gitsigns')

    local function bmap(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Navigation
    bmap('n', ']c', function()
      if vim.wo.diff then
        vim.cmd('normal! ]c')
      else
        gs.nav_hunk('next')
      end
    end, 'Jump to next git change')

    bmap('n', '[c', function()
      if vim.wo.diff then
        vim.cmd('normal! [c')
      else
        gs.nav_hunk('prev')
      end
    end, 'Jump to previous git change')

    -- Actions (visual mode)
    bmap('v', '<leader>hs', function()
      gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
    end, 'Git stage hunk')

    bmap('v', '<leader>hr', function()
      gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
    end, 'Git reset hunk')

    -- Actions (normal mode)
    bmap('n', '<leader>hs', gs.stage_hunk, 'Git stage hunk')
    bmap('n', '<leader>hr', gs.reset_hunk, 'Git reset hunk')
    bmap('n', '<leader>hS', gs.stage_buffer, 'Git stage buffer')
    bmap('n', '<leader>hu', gs.undo_stage_hunk, 'Git undo stage hunk')
    bmap('n', '<leader>hR', gs.reset_buffer, 'Git reset buffer')
    bmap('n', '<leader>hp', gs.preview_hunk, 'Git preview hunk')
    bmap('n', '<leader>hb', gs.blame_line, 'Git blame line')
    bmap('n', '<leader>hd', gs.diffthis, 'Git diff against index')
    bmap('n', '<leader>hD', function() gs.diffthis('@') end, 'Git diff against last commit')

    -- Toggles
    bmap('n', '<leader>tb', gs.toggle_current_line_blame, 'Toggle git blame line')
    bmap('n', '<leader>tD', gs.toggle_deleted, 'Toggle git show deleted')
  end,
})

-- DAP keymaps
map('n', '<F4>', ":lua require('dapui').toggle()<CR>", opts)
map('n', '<F5>', ":lua require'dap'.continue()<CR>", opts)
map('n', '<F7>', ":lua require'dap'.step_over()<CR>", opts)
map('n', '<F8>', ":lua require'dap'.step_into()<CR>", opts)
map('n', '<F9>', ":lua require'dap'.step_out()<CR>", opts)
map('n', '<leader>b', ":lua require'dap'.toggle_breakpoint()<CR>", opts)
map('n', '<leader>B', ':lua require\'dap\'.set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
map('n', '<leader>dr', ":lua require'dap'.repl.open()<CR>", opts)
map('n', '<leader>dl', ":lua require'dap'.run_last()<CR>", opts)

-- LSP general keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf
    local nmap = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = buf, desc = 'LSP: ' .. desc })
    end
    --nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
    nmap('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
    nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
    nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
    nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')

    -- Optional inlay hints toggle
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      nmap('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf })
      end, 'Toggle Inlay Hints')
    end
  end,
})

local function telescope_map(lhs, rhs, desc)
  vim.keymap.set('n', lhs, function()
    local ok, builtin = pcall(require, 'telescope.builtin')
    if ok then
      rhs(builtin)
    else
      vim.notify('Telescope not loaded', vim.log.levels.WARN)
    end
  end, { desc = desc })
end

telescope_map('<leader>sh', function(builtin) builtin.help_tags() end, '[S]earch [H]elp')
telescope_map('<leader>sk', function(builtin) builtin.keymaps() end, '[S]earch [K]eymaps')
telescope_map('<leader>sf', function(builtin) builtin.find_files() end, '[S]earch [F]iles')
telescope_map('<leader>ss', function(builtin) builtin.builtin() end, '[S]earch [S]elect Telescope')
telescope_map('<leader>sw', function(builtin) builtin.grep_string() end, '[S]earch current [W]ord')
telescope_map('<leader>sg', function(builtin) builtin.live_grep() end, '[S]earch by [G]rep')
telescope_map('<leader>sd', function(builtin) builtin.diagnostics() end, '[S]earch [D]iagnostics')
telescope_map('<leader>sr', function(builtin) builtin.resume() end, '[S]earch [R]esume')
telescope_map('<leader>s.', function(builtin) builtin.oldfiles() end, '[S]earch Recent Files')
telescope_map('<leader><leader>', function(builtin) builtin.buffers() end, 'Find existing buffers')

-- Fuzzy search in current buffer
telescope_map('<leader>/', function(builtin)
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
end, '[/] Fuzzily search in current buffer')

-- Live grep in open files
telescope_map('<leader>s/', function(builtin)
  builtin.live_grep({ grep_open_files = true, prompt_title = 'Live Grep in Open Files' })
end, '[S]earch [/] in Open Files')

-- Search Neovim config files
telescope_map('<leader>sn', function(builtin)
  builtin.find_files({ cwd = vim.fn.stdpath('config') })
end, '[S]earch [N]eovim files')

-- Copying

telescope_map('<localleader>yp', function()
  vim.fn.setreg('+', vim.fn.expand('%:p:.'))
end, '[Y]ank [P]ath')

telescope_map('<localleader>yd', function()
  vim.fn.setreg('+', vim.fn.expand('%:h'))
end, '[Y]ank [D]irectory')

telescope_map('<localleader>yf', function()
  vim.fn.setreg('+', vim.fn.expand('%:t:r'))
end, '[Y]ank [F]ile name')

