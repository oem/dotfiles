-- neovim configuration: Symlink ~/.config/nvim to this nvim directory.

-- Aliases
local cmd = vim.cmd
local fn = vim.fn
local o = vim.o
local bo = vim.bo
local wo = vim.wo

-- Keybindings
local map = require('config.utils').map
local autocmd = require('config.utils').autocmd
local silent = { silent = true }
local noremap = { noremap = true }

vim.g.mapleader = " "
map('i', 'fd', [[<esc>]], silent) -- alternative escape
map('c', '%%', [[<C-R>=expand('%:h').'/'<cr>]], noremap) -- current dir
map('n', '<leader><leader>', [[<c-^>]], noremap)

-- Package Manager
-- Bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Packages
require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Search
  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'telescope-frecency.nvim', -- improved sorting on recent files
        'telescope-fzf-native.nvim',
      },
      wants = {
        'popup.nvim',
        'plenary.nvim',
        'telescope-frecency.nvim',
        'telescope-fzf-native.nvim',
      },
      setup = [[require('config.telescope_setup')]],
      config = [[require('config.telescope')]],
      cmd = 'Telescope',
      module = 'telescope',
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      after = 'telescope.nvim',
      requires = 'tami5/sql.nvim',
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
  }

  -- Git
  use {
    { 'tpope/vim-fugitive', cmd = { 'Git', 'Git status', 'Git blame', 'Git push', 'Git pull' } },
    {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = [[require('config.gitsigns')]],
    },
    {
      'TimUntersberger/neogit',
      cmd = 'Neogit',
      config = function()
        require('neogit').setup {
          disable_commit_confirmation = true
        }
      end,
      setup = [[require('config.neogit')]]
    },
  }

  -- Completion and linting
  use {
    'onsails/lspkind-nvim',
    'neovim/nvim-lspconfig',
    'nvim-lua/lsp-status.nvim',
    'nvim-lua/lsp_extensions.nvim',
    'folke/trouble.nvim',
    'ray-x/lsp_signature.nvim',
    'kosayoda/nvim-lightbulb',
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      'hrsh7th/cmp-nvim-lsp',
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    },
    config = [[require('config.cmp')]],
    event = 'InsertEnter *',
  }

  -- Linting and fixing
  use 'dense-analysis/ale'

  -- Highlights
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    run = ':TSUpdate',
  }

  -- Commenting
  use 'tomtom/tcomment_vim'

  -- Editing
  use 'tpope/vim-surround'

  -- Moving
  use 'tpope/vim-unimpaired'
  use 'christoomey/vim-tmux-navigator'

  -- Debugger
  -- UI
  use 'reedes/vim-colors-pencil'
  -- Pretty symbols
  use 'kyazdani42/nvim-web-devicons'

  -- Statusline
  use {
    'famiu/feline.nvim',
    config = function()
      require('feline').setup({ preset = 'noicon' })
    end
  }

  -- Notes
  use { { 'kristijanhusak/orgmode.nvim', opt = true }, { 'akinsho/org-bullets.nvim', opt = true } }	
end)

-- Options
-- global options
o.ignorecase = true
o.swapfile = false
o.backup = false
o.wb = false
o.encoding = "utf-8"
o.hlsearch = false
o.incsearch = true
o.cpo = "$"
o.fillchars = "vert: ,eob: ,fold:·"
o.clipboard = "unnamedplus"
o.tabstop = 2
o.shiftwidth = 2
o.backspace = "indent,eol,start"
o.shell = "/bin/bash" -- remain posix compatible, even when using fish otherwise
o.background = "dark"
o.updatetime=300

-- window-local options
wo.number = false

-- buffer-local options
bo.expandtab = true -- we need to overwrite this for go buffers

-- Statusline
o.laststatus = 2

-- LSP
-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({})   

-- Enable solargraph/ruby
nvim_lsp.solargraph.setup({})

-- Enable typescript/javascript
nvim_lsp.tsserver.setup{}

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

-- Linting and fixing
vim.g.ale_fixers = {   
  ruby = { 'rubocop' },
  rust = { 'rustfmt' },
  python = { 'black' },
  go = { 'gofmt', 'goimports' },
  javascript = { 'prettier', 'eslint' },
}
vim.g.ale_fixers['*'] = { 'remove_trailing_lines', 'trim_whitespace'}
vim.g.ale_fix_on_save = 1
vim.g.ale_rust_rustfmt_options= '--edition 2018'

vim.g.ale_linters = {
  ruby = { 'solargraph', 'standardrb', 'rubocop' },
  python = { 'mypy', 'flake8', 'pylint' },
}
vim.g.ale_python_pylint_change_directory = 0
vim.g.ale_python_flake8_change_directory = 0

-- UI
cmd [[ colo pencil ]]

-- Cursorlines
autocmd('CursorLine', {
	'VimEnter,WinEnter,BufWinEnter * setlocal cursorline',
	'WinLeave * setlocal nocursorline'
}, true)

-- colors
cmd [[au VimEnter * hi VertSplit ctermfg=234 ctermbg=None cterm=None]]
cmd [[au VimEnter * hi Normal guibg=NONE ctermbg=NONE]]
cmd [[au VimEnter * hi StatusLine cterm=NONE ctermfg=7 ctermbg=None]]
cmd [[au VimEnter * hi StatusLineNC cterm=NONE ctermfg=8 ctermbg=None]]
cmd [[au VimEnter * hi Folded ctermbg=233 ctermfg=238]]
cmd [[au VimEnter * hi LineNr ctermbg=None ctermfg=236]]
cmd [[au VimEnter * hi CursorLineNr ctermfg=4]]
cmd [[au VimEnter * hi Comment ctermfg=238]]
cmd [[au VimEnter * hi SignColumn ctermbg=None]]
cmd [[au VimEnter * hi GitGutterAdd          ctermfg=2   ctermbg=2  guifg=#718c00 guibg=#718c00]]
cmd [[au VimEnter * hi GitGutterChange       ctermfg=3   ctermbg=3  guifg=#8959a8 guibg=#8959a8]]
cmd [[au VimEnter * hi GitGutterDelete       ctermfg=1   ctermbg=1  guifg=#d75e00 guibg=#d75e00]]
cmd [[au VimEnter * hi GitGutterChangeDelete ctermfg=13  ctermbg=13 guifg=#d6225e guibg=#d6225e]]

