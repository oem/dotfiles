set nocompatible
filetype off
set shell=/bin/bash
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'

" my bundles
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-endwise.git'
Plugin 'tpope/vim-ragtag.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'tpope/vim-bundler.git'
Plugin 'tpope/vim-haml.git'
Plugin 'junegunn/vim-easy-align'
Plugin 'bling/vim-airline'
Plugin 'rking/ag.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'tomtom/tcomment_vim.git'
Plugin 'digitaltoad/vim-jade.git'
Plugin 'claco/jasmine.vim.git'
Plugin 'airblade/vim-gitgutter'
Plugin 'pangloss/vim-javascript'
Plugin 'mattn/emmet-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'Shougo/neocomplete.vim'
Plugin 'jamessan/vim-gnupg'
Plugin 'nacitar/terminalkeys.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-dispatch'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'fatih/vim-go'
Plugin 'hsanson/vim-android'

Plugin 'file://.vim/bundle/krittapong'
Plugin 'file://.vim/bundle/colors-github'
Plugin 'file://.vim/bundle/javascript'
Plugin 'file://.vim/bundle/oem'

" vim-rspec
let g:rspec_command = "Dispatch zeus spec {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

nnoremap <F9> :Dispatch<CR>

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" " Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" align
" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
"
" " Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)

filetype plugin indent on
set backspace=indent,eol,start
set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smarttab
set ignorecase
set encoding=utf-8

set ttyfast
set number

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

set t_Co=256
colo krittapong-dark
set term=$TERM

" set statusline=[%02n]%y\ %f\ %(\[%M%R%H]%)\ %{fugitive#statusline()\ }[%b][0x%B]%=\ %4l,%02c%2V\ %P%*
set laststatus=2

set showtabline=1
set noequalalways

"folding
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=1

" guioptions
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guioptions+=e

let g:CommandTMaxHeight=20
map <leader>f :CommandT<cr>

let g:airline_theme='serene'

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    "   " render properly when inside 256-color tmux and GNU screen.
    "     " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

" rails.vim settings
let g:rails_default_file='config/database.yml'

" snipmate
imap kk <esc>a<Plug>snipMateNextOrTrigger
smap kk <Plug>snipMateNextOrTrigger

" show invisibles
set list
set listchars=tab:»\ ,eol:«

" nnoremap <esc> :noh<CR><esc>
map <F1> :tabp<CR>
map <F2> :tabn<CR>
map <F4> :noh<CR>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
nmap <C-L> <C-W>l<C-W>\|
nmap <C-H> <C-W>h<C-W>\|
map <F5> :CtrlP<CR>
map <F6> :CtrlPBuffer<CR>

inoremap jj <esc>
imap <leader><cr> <esc>o
nnoremap <leader><leader> <c-^>

" backup dir for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" handling whitespaces
autocmd BufWritePre * :%s/\s\+$//e

nmap tn :tabnew<CR>
iab <expr> dts strftime("%c")

let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Close_On_Select = 1
let Tlist_Show_One_File = 1
let Tlist_Compact_Format = 1
nnoremap <silent> <F8> :TlistOpen<CR>

" automatically change directory to current buffers location
" autocmd BufEnter * lcd %:p:h

set dictionary+=/usr/share/dict/words

" shows a dollar sign at the end of a change range
set cpo+=$

let g:sparkupNextMapping = '<c-x>'
let g:user_emmet_leader_key = '<c-e>'

" for vim-coffee-script: automatically compile to javascript on save
let coffee_script_compile_on_save = 1

" current dir insertion
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" For programming languages using a semi colon at the end of statement.
autocmd FileType c,cpp,css,java,javascript,perl,php,actionscript
      \ nmap <silent> <Leader>; :call <SID>appendSemiColon()<cr>

" Actionscript stuff
autocmd BufNewFile,BufRead *.as set filetype=actionscript

" Assembler
autocmd BufNewFile,BufRead *.asm set filetype=tasm

" bundler
autocmd BufNewFile,BufRead Gemfile set filetype=ruby

" rack
autocmd BufNewFile,BufRead *.ru set filetype=ruby

" json
autocmd BufNewFile,BufRead *.json set filetype=javascript

" jbuilder
autocmd BufNewFile,BufRead *.jbuilder set filetype=ruby

" rabl
autocmd BufNewFile,BufRead *.rabl set filetype=ruby

" mustache
autocmd BufNewFile,BufRead *.mustache set filetype=html

" handlebars
autocmd BufNewFile,BufRead *.hbs set filetype=html

autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType javascript let b:dispatch = 'mocha % -R min'

" jasmine
autocmd BufNewFile,BufRead *spec.*coffee set filetype=jasmine.coffeescript
autocmd BufNewFile,BufRead *spec.js set filetype=jasmine.javascript

au WinLeave * set nocursorline
" au WinEnter * set cursorline

" fuzzy finder with dmenu
map <c-f> :call DmenuOpen("e")<cr>

" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

function! ExtractBuf()
  let str = execute('ls')
  return substitute(str, '^.*\"\(.*\)\".*$', '\1\n', '')
endfunction

" Find a file and pass it to cmd
function! DmenuOpen(cmd)
  let font = "-*-tamsyn-medium-*-*-*-16-*-*-*-*-*-*-*"
  let fg = "#757978"
  let fg_selected = "#C1C4BC"
  let bg = "#1C1C1C"

  let fname = Chomp(system("git ls-files | dmenu -i -l 20 -nb '#1c1c1c' -nf '#757978' -sb '#1c1c1c' -fn " . font . " -p " . a:cmd))
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname
endfunction

" static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", colors[0][ColBG], "-nf", colors[0][ColFG], "-sb", colors[1][ColBG], "-sf", colors[1][ColFG], NULL };
