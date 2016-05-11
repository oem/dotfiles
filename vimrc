set nocompatible
filetype off
set shell=/bin/bash

" installing the plugins
call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-haml'
Plug 'junegunn/vim-easy-align'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rking/ag.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'tomtom/tcomment_vim'
Plug 'digitaltoad/vim-pug'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'
Plug 'kchmck/vim-coffee-script'
Plug 'Shougo/neocomplete.vim'
Plug 'jamessan/vim-gnupg'
Plug 'nacitar/terminalkeys.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-dispatch'
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
call plug#end()

" vim-rspec
let g:rspec_command = "Dispatch bin/rspec {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

nnoremap <F9> :Dispatch<CR>

" tmux nav
" let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-H> :TmuxNavigateLeft<cr> <C-W>\|
nnoremap <silent> <C-J> :TmuxNavigateDown<cr> <C-W>_
nnoremap <silent> <C-K> :TmuxNavigateUp<cr> <C-W>_
nnoremap <silent> <C-L> :TmuxNavigateRight<cr> <C-W>\|

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

" go stuff
let g:go_fmt_command="goimports"

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
" set foldmethod=syntax
" set foldnestmax=10
" set nofoldenable
" set foldlevel=1

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
map <F4> :noh<CR>

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

" static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", colors[0][ColBG], "-nf", colors[0][ColFG], "-sb", colors[1][ColBG], "-sf", colors[1][ColFG], NULL };
