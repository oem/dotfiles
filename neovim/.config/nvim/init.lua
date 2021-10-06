-- neovim configuration: Symlink ~/.config/nvim to this nvim directory.

-- Aliases
local cmd = vim.cmd
local fn = vim.fn
local o = vim.o
local bo = vim.bo
local wo = vim.wo
local opt = vim.opt
local exec = vim.api.nvim_exec -- execute Vimscript

-- Keybindings
local map = require('config.utils').map
local autocmd = require('config.utils').autocmd
local options = { noremap = true, silent = true }

vim.g.mapleader = " "
map('i', 'fd', [[<esc>]], options) -- alternative escape
map('c', '%%', [[<C-R>=expand('%:h').'/'<cr>]], { noremap = true }) -- current dir
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
o.updatetime=300
o.smartindent = true
o.expandtab = true

-- Neovim UI
o.laststatus = 2
o.showmatch = true
o.cpo = "$"
o.fillchars = "vert: ,eob: ,fold:·"
o.background = "dark"
o.cursorcolumn = true

opt.listchars = {
  space = "·"
}

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
local nvim_lsp = require'lspconfig'

-- Languages

-- rust
-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({})

--julia
-- set autoindent to 4 spaces as per styleguide
cmd[[autocmd FileType julia setlocal shiftwidth=4 tabstop=4 expandtab]]

-- ruby
-- Enable solargraph/ruby
nvim_lsp.solargraph.setup({})

-- javascript
-- Enable typescript/javascript
nvim_lsp.tsserver.setup{}

-- python
--  Enable python/pyright_
require'lspconfig'.pyright.setup{}

-- elm
-- Enable elm language server
require'lspconfig'.elmls.setup{}

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  update_in_insert = true,
}
)
autocmd(nil, 'CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()', nil)

-- enable inline hints
autocmd(nil, 'CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require\'lsp_extensions\'.inlay_hints{ prefix = "", highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }', nil)

-- code navigation
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', options)

-- Linting and fixing
vim.g.ale_fixers = {
  ruby = { 'rubocop' },
  rust = { 'rustfmt' },
  python = { 'black' },
  go = { 'gofmt', 'goimports' },
  javascript = { 'prettier', 'eslint' },
  elm = { 'elm-format' },
}
vim.g.ale_fix_on_save = 1
vim.g.ale_rust_rustfmt_options= '--edition 2018'

vim.g.ale_linters = {
  ruby = { 'solargraph', 'standardrb', 'rubocop' },
  python = { 'mypy', 'flake8', 'pylint' },
  elm = {},
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
cmd [[au VimEnter * hi VertSplit ctermfg=234 ctermbg=None cterm=None]]
cmd [[au VimEnter * hi Normal guibg=NONE ctermbg=NONE]]
cmd [[au VimEnter * hi StatusLine cterm=NONE ctermfg=7 ctermbg=None]]
cmd [[au VimEnter * hi StatusLineNC cterm=NONE ctermfg=8 ctermbg=None]]
cmd [[au VimEnter * hi Folded ctermbg=233 ctermfg=8]]
cmd [[au VimEnter * hi LineNr ctermbg=None ctermfg=8]]
cmd [[au VimEnter * hi CursorLineNr ctermfg=7]]
cmd [[au VimEnter * hi SignColumn ctermbg=None]]
cmd [[au VimEnter * hi GreenSign ctermfg=10]]
cmd [[au VimEnter * hi BlueSign ctermfg=12]]
cmd [[au VimEnter * hi RedSign ctermfg=9]]
cmd [[au VimEnter * hi PurpleSign ctermfg=13]]
cmd [[au VimEnter * hi ALEWarning ctermbg=None]]
cmd [[au VimEnter * hi ALEError ctermbg=None]]
cmd [[au VimEnter * hi ALEWarningSign ctermbg=None]]
cmd [[au VimEnter * hi ALEErrorSign ctermbg=None]]
