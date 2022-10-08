-- Aliases
local cmd = vim.cmd
local o = vim.o
local bo = vim.bo
local wo = vim.wo
local opt = vim.opt
local exec = vim.api.nvim_exec -- execute Vimscript

-- Keybindings
local map = require('config.utils').map
local autocmd = require('config.utils').autocmd
local options = {noremap = true, silent = true}

vim.g.mapleader = " "
map('i', 'fd', [[<esc>]], options) -- alternative escape
map('c', '%%', [[<C-R>=expand('%:h').'/'<cr>]], {noremap = true}) -- current dir
map('n', '<leader><leader>', [[<c-^>]], options) -- toggle between buffers

-- Some helpers
require('oem.globals')

-- packages
require('packages')

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
o.cursorcolumn = true

opt.listchars = {space = "·"}

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
o.lazyredraw = true
o.synmaxcol = 240

-- window-local options
wo.number = true
wo.signcolumn = 'yes'
wo.list = true

-- buffer-local options
bo.expandtab = true -- we need to overwrite this for go buffers

-- LSP
local lsp_installer = require 'nvim-lsp-installer'

lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- rust-tools already sets up the lsp server rust_analyzer
    if server.name == "rust_analyzer" then return end

    if server.name == "pyright" then return end

    if server.name == "volar" then
        opts.filetypes = {
            'typescript', 'javascript', 'javascriptreact', 'typescriptreact',
            'vue', 'json'
        }
        opts.init_options = {
            typescript = {
                serverPath = os.getenv("HOME") ..
                    "/.local/share/nvim/lsp_servers/tsserver/node_modules/typescript/lib/tsserverlibrary.js"
            }
        }
    end

    if server.name == "sumneko_lua" then
        opts.cmd = {'lua-language-server'}
        opts.settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';')
                },
                diagnostics = {globals = {'vim', 'use'}}
            }
        }
    end

    server:setup(opts)
end)

-- Languages

-- julia
-- set autoindent to 4 spaces as per styleguide
cmd [[autocmd FileType julia setlocal shiftwidth=4 tabstop=4 expandtab]]

-- go
-- don't show ugly tabs
cmd [[autocmd FileType go setlocal nolist]]

-- ruby
cmd [[autocmd BufNewFile,BufRead *.jbuilder set filetype=ruby]]

-- html
cmd [[autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab]]

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = true, signs = true, update_in_insert = true})
-- autocmd(nil, 'CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()', nil)

-- code navigation
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', options)
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', options)

-- Linting and fixing
-- ALE should run rubocop via bundle exec
cmd [[let g:ale_ruby_rubocop_executable = 'bundle']]

vim.g.ale_fixers = {
    ruby = {'rubocop'},
    rust = {'rustfmt'},
    python = {'black'},
    go = {'gofmt', 'goimports'},
    javascript = {'prettier', 'eslint'},
    typescript = {'prettier', 'eslint'},
    vue = {'prettier', 'eslint'},
    html = {'prettier'},
    elm = {'elm-format'},
    -- luarocks install --server=https://luarocks.org/dev luaformatter
    lua = {'lua-format'},
    -- stack install ormolu
    haskell = {'ormolu'}
}
vim.g.ale_fix_on_save = 1
vim.g.ale_rust_rustfmt_options = '--edition 2018'

vim.g.ale_linters = {
    ruby = {'solargraph', 'standardrb', 'rubocop'},
    python = {},
    go = {},
    rust = {},
    lua = {},
    elm = {},
    haskell = {'stack-ghc'},
    css = {},
    vue = {},
    javascript = {},
    typescript = {}
}
vim.g.ale_python_pylint_change_directory = 0
vim.g.ale_python_flake8_change_directory = 0

-- strip whitespace on save
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0

-- UI
-- Cursorlines
autocmd('CursorLine', {
    'VimEnter,WinEnter,BufWinEnter * setlocal cursorline',
    'WinLeave * setlocal nocursorline'
}, true)

autocmd('CursorColumn', {
    'VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn',
    'WinLeave * setlocal nocursorcolumn'
}, true)

autocmd('LineNr', {
    'VimEnter,WinEnter,BufWinEnter * setlocal nu rnu',
    'WinLeave * setlocal nornu nu'
}, true)

-- lsp signs
cmd [[
    sign define DiagnosticSignError text= linehl= texthl=DiagnosticSignError numhl=
    sign define DiagnosticSignWarn text=⊘ linehl= texthl=DiagnosticSignWarn numhl=
    sign define DiagnosticSignInfo text= linehl= texthl=DiagnosticSignInfo numhl=
    sign define DiagnosticSignHint text= linehl= texthl=DiagnosticSignHint numhl=
]]

-- colors
vim.api.nvim_command "colo pencil"

cmd [[au VimEnter * hi VertSplit ctermfg=234 ctermbg=None cterm=None guifg=None guibg=None]]
-- cmd [[au VimEnter * hi Normal guibg=None ctermbg=None]]
cmd [[au VimEnter * hi StatusLine cterm=NONE ctermfg=7 ctermbg=None]]
cmd [[au VimEnter * hi StatusLineNC cterm=NONE ctermfg=8 ctermbg=None]]
cmd [[au VimEnter * hi Folded ctermbg=233 ctermfg=8]]
cmd [[au VimEnter * hi CursorLineNr ctermfg=8 guifg=#767676]]
cmd [[au VimEnter * hi SignColumn ctermbg=None]]
cmd [[au VimEnter * hi GreenSign ctermfg=10 guifg=#10A778]]
cmd [[au VimEnter * hi BlueSign ctermfg=12 guifg=#008EC4]]
cmd [[au VimEnter * hi RedSign ctermfg=9 guifg=#C30771]]
cmd [[au VimEnter * hi PurpleSign ctermfg=13 guifg=#523C79]]
cmd [[au VimEnter * hi ALEWarning ctermbg=None]]
cmd [[au VimEnter * hi ALEError ctermbg=None]]
cmd [[au VimEnter * hi ALEWarningSign ctermbg=None]]
cmd [[au VimEnter * hi ALEErrorSign ctermbg=None]]
