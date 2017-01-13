" vim:fdm=marker

" plugins {{{
call plug#begin('~/.vim/bundle')
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-bundler'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'rking/ag.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'tomtom/tcomment_vim'
Plug 'digitaltoad/vim-pug'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'neomake/neomake'
Plug 'jamessan/vim-gnupg'
Plug 'nacitar/terminalkeys.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-dispatch'
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
" improved incsearch
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
call plug#end()
" }}}
" plugins config {{{
let g:deoplete#enable_at_startup = 1
" align
" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

imap <expr><TAB>
      \ pumvisible() ? "\<C-n>" :
      \ neosnippet#expandable_or_jumpable() ?
      \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" neomake
autocmd! BufWritePost * Neomake
let g:neomake_error_sign = {'text': '*', 'texthl': 'NeomakeErrorSign'}
map <c-F> :FZF<cr>

" incsearch
map / <Plug>(incsearch-fuzzy-/)
map ? <Plug>(incsearch-fuzzy-?)
map g/ <Plug>(incsearch-fuzzy-stay)
"easymotion

" }}}
" basic config {{{
filetype off
set shell=/bin/bash " still have posix compatible shell even if we are using a diff shell like fish
filetype plugin indent on
set backspace=indent,eol,start
set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smarttab
set ignorecase
set encoding=utf-8
set synmaxcol=200

set relativenumber

" regexp like perl
"nnoremap / /\v

set scs
set incsearch
set hlsearch
set tw=0 wrap linebreak
set showmode
set nobackup
set wildmenu
syntax on
" set t_Co=256
" colo krittapong-dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colo onedark

" show invisibles
set list
set listchars=tab:»\ ,eol:«
map <F4> :noh<CR>
" shows a dollar sign at the end of a change range
set cpo+=$

inoremap jj <esc>
imap <leader><cr> <esc>o
nnoremap <leader><leader> <c-^>
" backup dir for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup
" clipboard
set clipboard+=unnamed

" leader key
map <SPACE> <leader>
map <SPACE><SPACE> <leader><leader>

" statusbar
" let g:airline_theme='serene'
" let g:airline_theme='onedark'
set statusline=[%02n]%y\ %f\ %(\[%M%R%H]%)\ %{fugitive#statusline()\ }[%b][0x%B]%=\ %4l,%02c%2V\ %P%*
set laststatus=2
set showtabline=1
set noequalalways

" current dir insertion
cnoremap %% <C-R>=expand('%:h').'/'<cr>
" }}}
" tmux / dispatch {{{
" vim-rspec
let g:rspec_command = "Dispatch bundle exec rspec {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

nnoremap <F9> :Dispatch<CR>

" tmux nav
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-H> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-J> :TmuxNavigateDown<cr> <C-W>_
nnoremap <silent> <C-K> :TmuxNavigateUp<cr> <C-W>_
nnoremap <silent> <C-L> :TmuxNavigateRight<cr>
" }}}
" golang {{{
let g:go_fmt_command="goimports"
autocmd FileType go nmap <leader>t  <Plug>(go-test)
" }}}
" rust {{{
let g:rustfmt_autosave = 1
set hidden
let g:racer_cmd = "/home/oem/.cargo/bin/racer"
let $RUST_SRC_PATH="/home/oem/src/rust/src/"
" }}}
" ruby {{{
let g:rails_default_file='config/database.yml'
" bundler
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
" rack
autocmd BufNewFile,BufRead *.ru set filetype=ruby
" jbuilder
autocmd BufNewFile,BufRead *.jbuilder set filetype=ruby
" rabl
autocmd BufNewFile,BufRead *.rabl set filetype=ruby
" unfold initially
autocmd Syntax ruby normal zR
" }}}
" frontend {{{
let g:user_emmet_leader_key = '<c-e>'

" react
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}
let g:jsx_ext_required = 0
let g:neomake_javascript_enabled_makers = ['eslint']

" json
autocmd BufNewFile,BufRead *.json set filetype=javascript
" mustache
autocmd BufNewFile,BufRead *.mustache set filetype=html
" handlebars
autocmd BufNewFile,BufRead *.hbs set filetype=html
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType javascript let b:dispatch = 'mocha % -R min'
" jasmine
autocmd BufNewFile,BufRead *spec.*coffee set filetype=jasmine.coffeescript
autocmd BufNewFile,BufRead *spec.js set filetype=jasmine.javascript
" }}}
" Assembler {{{
autocmd BufNewFile,BufRead *.asm set filetype=tasm
" }}}
" remove whitespaces {{{
autocmd BufWritePre * :%s/\s\+$//e
" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

function! ExtractBuf()
  let str = execute('ls')
  return substitute(str, '^.*\"\(.*\)\".*$', '\1\n', '')
endfunction

" }}}
" dmenu {{{
" fuzzy finder with dmenu
" map <c-f> :call DmenuOpen("e")<cr>

" Find a file and pass it to cmd
function! DmenuOpen(cmd)
  let font = "Tamsyn:pixelsize=20"
  let fg = "#757978"
  let fg_selected = "#C1C4BC"
  let bg = "#1C1C1C"

  let fname = Chomp(system("git ls-files | dmenu -i -l 20 -nb '#1c1c1c' -nf '#757978' -sb '#1c1c1c' -fn " . font . " -p " . a:cmd))
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname
endfunction
" }}}

