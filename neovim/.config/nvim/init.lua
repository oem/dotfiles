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
local nvim_lsp = require 'lspconfig'

-- install language servers
local function setup_servers()
    require'lspinstall'.setup()
    local servers = require'lspinstall'.installed_servers()
    for _, server in pairs(servers) do require'lspconfig'[server].setup {} end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- Languages

-- rust
-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup {}

-- julia
-- set autoindent to 4 spaces as per styleguide
cmd [[autocmd FileType julia setlocal shiftwidth=4 tabstop=4 expandtab]]

-- go
-- don't show ugly tabs
cmd [[autocmd FileType go setlocal nolist]]
nvim_lsp.gopls.setup {}

-- ruby
-- Enable solargraph/ruby
nvim_lsp.solargraph.setup {}
cmd [[autocmd BufNewFile,BufRead *.jbuilder set filetype=ruby]]

-- javascript
-- Enable typescript/javascript
nvim_lsp.tsserver.setup {}

-- python
--  Enable python/pyright
nvim_lsp.pyright.setup {}

-- elm
-- Enable elm language server
nvim_lsp.elmls.setup {}

-- haskell
-- Enable haskell language server
nvim_lsp.hls.setup {}

-- lua
-- Enable lua language server, installed with pacman -S lua-language-server
nvim_lsp.sumneko_lua.setup {
    cmd = {'lua-language-server'},
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {globals = {'vim', 'use'}}
        }
    }
}

-- html
-- npm i -g vscode-langservers-extracted
nvim_lsp.html.setup {}
nvim_lsp.cssls.setup {}

-- tailwind
-- npm install -g @tailwindcss/language-server
nvim_lsp.tailwindcss.setup {}

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = true, signs = true, update_in_insert = true})
-- autocmd(nil, 'CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()', nil)

-- enable inline hints
autocmd(nil,
        'CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require\'lsp_extensions\'.inlay_hints{ prefix = "", highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }',
        nil)

-- code navigation
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', options)
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', options)

-- Linting and fixing
vim.g.ale_fixers = {
    ruby = {'rubocop'},
    rust = {'rustfmt'},
    python = {'black'},
    go = {'gofmt', 'goimports'},
    javascript = {'prettier', 'eslint'},
    typescript = {'prettier', 'eslint'},
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
    python = {'mypy', 'flake8', 'pylint'},
    go = {},
    rust = {},
    lua = {},
    elm = {},
    haskell = {'stack-ghc'}
}
vim.g.ale_python_pylint_change_directory = 0
vim.g.ale_python_flake8_change_directory = 0

-- strip whitespace on save
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0

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

-- UI
cmd [[ colo pencil ]]

-- colors
cmd [[au VimEnter * hi VertSplit ctermfg=234 ctermbg=None cterm=None guifg=None guibg=None]]
cmd [[au VimEnter * hi Normal guibg=None ctermbg=None]]
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
