vim.opt.expandtab = false
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 8
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 2
vim.opt.termguicolors = true
-- Set the statusline to use Airline
vim.opt.statusline = "%{v:lua.airline#statusline()}"
vim.opt.encoding = "utf-8"

-- Setup lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Define plugins
local plugins = {
    { "nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = { "nvim-lua/plenary.nvim" } },
    --{ "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } }
    { "preservim/nerdtree" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "williamboman/mason.nvim", build = ":MasonUpdate" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/vim-vsnip" },
    { "hrsh7th/vim-vsnip-integ" },
    { "rafamadriz/friendly-snippets" },
    { "preservim/nerdtree" },
    { "vim-airline/vim-airline" },
    { "vim-airline/vim-airline-themes" },
    { "tpope/vim-fugitive" },
    { "windwp/nvim-autopairs" },
    { "mfussenegger/nvim-jdtls" },
    { "airblade/vim-gitgutter" },
    { "lervag/vimtex" },
    { "nvim-java/nvim-java" },
    { "simrat39/rust-tools.nvim" }, -- Rust tools plugin
}

vim.api.nvim_set_keymap("n", "<F5>", ":NERDTreeToggle<CR>", { noremap = true, silent = true })

-- Set the Airline theme
vim.g.airline_theme = "powerlineish"

-- Custom separators for Airline
--vim.g.airline_left_sep = ''
--vim.g.airline_left_alt_sep = ''
--vim.g.airline_right_sep = ''
--vim.g.airline_right_alt_sep = ''

vim.g.airline_left_sep = ''
vim.g.airline_left_alt_sep = ''
vim.g.airline_right_sep = ''
vim.g.airline_right_alt_sep = ''

-- Ensure the powerline fonts are being used
vim.g.airline_powerline_fonts = 1

-- Enable Fugitive and Branch extensions in Airline
vim.g['airline#extensions#fugitive#enabled'] = 1
vim.g['airline#extensions#branch#enabled'] = 1
vim.g['airline#extensions#hunks#enabled'] = 1

-- Set up lazy.nvim with the plugins
local opt = {}
require("lazy").setup(plugins, opt)

-- Set the colorscheme to molokai
vim.cmd("colorscheme molokai")

-- Configure Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})

-- Define common_on_attach function
local common_on_attach = function(client, bufnr)
    -- Disable automatic formatting for all LSP clients
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    print("Language Server " .. client.name .. " started!")
end

-- Configure LSP for Java
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- clangd (C++)
require'lspconfig'.clangd.setup{
    capabilities = capabilities,
    on_attach = common_on_attach,
    cmd = { "clangd", "--background-index" },
}

-- rust-analyzer (Rust)
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "jdtls", "rust_analyzer" },
})

lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = common_on_attach,
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = {
                command = "clippy",
            },
        },
    },
})

-- rust-tools.nvim setup
require("rust-tools").setup({
    server = {
        capabilities = capabilities,
        on_attach = common_on_attach,
    },
    tools = {
        autoSetHints = true,
        inlay_hints = {
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
        },
    },
})

-- Treesitter
local configs = require("nvim-treesitter.configs")
configs.setup({
    ensure_installed = { "lua", "cpp", "java", "c", "markdown", "vim", "python", "rust" },
    highlight = { enable = true },
    indent = { enable = true },
})

-- Setup nvim-cmp
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "vsnip" },
    },
})

-- Configure nvim-autopairs
require("nvim-autopairs").setup({
    check_ts = true,
    disable_filetype = { "TelescopePrompt" },
})
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- Enable VimTeX settings
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
vim.g.vimtex_compiler_method = 'latexrun'

-- Ensure VimTeX syntax highlighting and indentation are enabled
vim.cmd([[
filetype plugin indent on
syntax enable
]])
vim.opt.syntax = "enable"

-- Change maplocalleader
vim.g.maplocalleader = ","

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then return end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function() io.write("\027]111\027\\") end,
})
