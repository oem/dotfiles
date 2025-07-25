-- Aliases
local cmd = vim.cmd
local o = vim.o
local bo = vim.bo
local wo = vim.wo
-- local opt = vim.opt
local exec = vim.api.nvim_exec -- execute Vimscript

-- Keybindings
local map = require('config.utils').map
local autocmd = require('config.utils').autocmd
local options = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "
map('i', 'fd', [[<esc>]], options)                                  -- alternative escape
map('c', '%%', [[<C-R>=expand('%:h').'/'<cr>]], { noremap = true }) -- current dir
map('n', '<leader><leader>', [[<c-^>]], options)                    -- toggle between buffers
map('n', '<C-u>', '<C-u>zz', options)
map('n', '<C-d>', '<C-d>zz', options)

-- folding
o.foldcolumn = '0'
o.foldlevel = 99
o.foldlevelstart = 99
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldenable = true

-- Some helpers
require('oem.globals')

-- Options
-- global options
o.ignorecase = true
o.swapfile = false
o.backup = false
o.wb = false
o.encoding = "utf-8"
o.hlsearch = false
o.incsearch = true
o.clipboard = 'unnamedplus' -- uses CLIPBOARD (^C)
o.tabstop = 4
o.shiftwidth = 4
o.backspace = "indent,eol,start"
o.shell = "/bin/bash" -- remain posix compatible, even when using fish otherwise
o.updatetime = 300
o.smartindent = true
o.expandtab = true
o.termguicolors = true

-- Neovim UI
o.laststatus = 2
o.showmatch = true
o.cpo = "$"
o.fillchars = "vert: ,eob: ,fold:·"
o.background = "dark"

-- opt.listchars = { space = "·" }

-- packages
require('packages')

-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
  augroup end
]], false)

-- Memory/CPU
o.hidden = true
o.history = 100
o.synmaxcol = 240

-- window-local options
wo.number = true
wo.list = true

-- buffer-local options
bo.expandtab = true -- we need to overwrite this for go buffers

-- LSP
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd" }
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim', 'use' } },
            telemetry = {
                enable = false,
            },
        }
    }
})

-- Languages

-- go
-- don't show ugly tabs
cmd [[autocmd FileType go setlocal nolist]]

-- ruby
cmd [[autocmd BufNewFile,BufRead *.jbuilder set filetype=ruby]]

-- html
cmd [[autocmd BufNewFile,BufRead *.html set filetype=html]]

-- code navigation
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', options)
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', options)

vim.keymap.set('n', '<leader>vd', function()
    vim.diagnostic.open_float({
        height = 20,
        width = 100,
    })
end)

-- Linting and fixing
cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- strip whitespace on save
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0

-- UI
-- Cursorlines
autocmd('CursorLine', {
    'VimEnter,WinEnter,BufWinEnter * setlocal cursorline',
    'WinLeave * setlocal nocursorline'
}, true)

autocmd('LineNr', {
    'VimEnter,WinEnter,BufWinEnter * setlocal nu rnu',
    'WinLeave * setlocal nornu nu'
}, true)

-- Load the colorscheme
vim.cmd.colorscheme("monobold")

-- lsp signs
cmd [[
    sign define DiagnosticSignError text=● linehl= texthl=DiagnosticSignError numhl=
    sign define DiagnosticSignWarn text=● linehl= texthl=DiagnosticSignWarn numhl=
    sign define DiagnosticSignInfo text=● linehl= texthl=DiagnosticSignInfo numhl=
    sign define DiagnosticSignHint text=●  linehl= texthl=DiagnosticSignHint numhl=
]]

-- colors
-- vim.api.nvim_command "colo binary"
vim.api.nvim_set_hl(0, 'SignColumn', { bg = "none" })
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = "#cf001e" })
vim.api.nvim_set_hl(0, 'DiagnosticSignError', { fg = "#cf001e" })
vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { fg = "#ff5700" })
vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', { fg = "#ff5700" })
