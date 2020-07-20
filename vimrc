" vim:fdm=marker

" plugins {{{
call plug#begin('~/.local/share/nvim/site/bundle')
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'tpope/vim-endwise'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'terryma/vim-multiple-cursors'

Plug 'neomake/neomake'

Plug 'jalvesaq/vimcmdline'

" Linting, autofixing
Plug 'dense-analysis/ale'

" comments
Plug 'tpope/vim-commentary'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" julia
Plug 'JuliaEditorSupport/julia-vim'

" python
Plug 'ambv/black'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" ruby
Plug 'tpope/vim-rails'
Plug 'rlue/vim-fold-rspec'

" javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
Plug 'Quramy/vim-js-pretty-template'

" go
Plug 'sebdah/vim-delve'
Plug 'fatih/vim-go'

" rust
Plug 'rust-lang/rust.vim'

" markdown
Plug 'tpope/vim-markdown'

" auto complete and other insert mode completions, like snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'majutsushi/tagbar'
Plug 'Shougo/echodoc'

" themes
Plug 'joshdick/onedark.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'tomasiser/vim-code-dark'
Plug 'KimNorgaard/vim-frign'
Plug 'tomasr/molokai'
Plug 'fmoralesc/molokayo'
Plug 'balanceiskey/vim-framer-syntax'
Plug 'reedes/vim-colors-pencil'

Plug 'jamessan/vim-gnupg'
Plug 'nacitar/terminalkeys.vim'
Plug 'tpope/vim-dispatch'
Plug 'christoomey/vim-tmux-navigator'

Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'

" improved incsearch
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

call plug#end()
" }}}
" plugins config {{{

" close the preview window after completion is done
autocmd CompleteDone * silent! pclose!

" orgmode
:let g:org_agenda_files=['~/org/*.org', '~/org/projects/*.org']

" folding
set nofoldenable

let g:UltiSnipsExpandTrigger="<C-k>"

set cmdheight=1
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'

" incsearch
map /f <Plug>(incsearch-fuzzy-/)
map ?f <Plug>(incsearch-fuzzy-?)
map g/ <Plug>(incsearch-fuzzy-stay)

"easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1

" incsearch.vim x fuzzy x vim-easymotion
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
        \   'converters': [incsearch#config#fuzzy#converter()],
        \   'modules': [incsearch#config#easymotion#module()],
        \   'keymap': {"\<CR>": '<Over>(easymotion)'},
        \   'is_expr': 0,
        \   'is_stay': 1
        \ }), get(a:, 1, {}))
endfunction
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
set nonumber

set scs
set scl=yes
set incsearch
set hlsearch
set tw=0 wrap linebreak
set showmode
set wildmenu
syntax enable

" Turn Off Swap Files
set noswapfile
set nobackup
set nowb

" disable highlight search
set nohlsearch

" show invisibles
set fillchars+=vert:\ ,eob:\ ,fold:·
" set list
" set listchars=tab:»\ ,eol:«

" shows a dollar sign at the end of a change range
set cpo+=$

" clipboard
set clipboard+=unnamed

" cursor highlighting
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" current dir insertion
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" fold fish files and vim files initially
au BufReadPost,BufNewFile .vimrc,vimrc,*.fish normal zM
" }}}
" {{{ ui
set  background=dark
colo pencil

" hi Search ctermfg=0 ctermbg=4
" hide the empty buffer character
" highlight EndOfBuffer ctermfg=bg

hi VertSplit ctermfg=None ctermbg=None cterm=None
" hi CursorLine ctermbg=17
hi Normal guibg=NONE ctermbg=NONE
hi StatusLine cterm=NONE ctermfg=7 ctermbg=None
hi StatusLineNC cterm=NONE ctermfg=8 ctermbg=None
" hi Folded ctermbg=237 ctermfg=15
hi LineNr ctermbg=None ctermfg=236
hi CursorLineNr ctermfg=4
" hi Visual ctermbg=4

" gitgutter
hi GitGutterAdd          ctermfg=2   ctermbg=2  guifg=#718c00 guibg=#718c00
hi GitGutterChange       ctermfg=3   ctermbg=3  guifg=#8959a8 guibg=#8959a8
hi GitGutterDelete       ctermfg=1   ctermbg=1  guifg=#d75e00 guibg=#d75e00
hi GitGutterChangeDelete ctermfg=13  ctermbg=13 guifg=#d6225e guibg=#d6225e
set updatetime=100

hi Pmenu ctermbg=0

" ale
hi ALEWarning ctermbg=100 ctermfg=15
hi ALEError ctermbg=202 ctermfg=15
hi ALEErrorSign ctermbg=202
hi ALEWarningSign ctermbg=100

" fzf styling
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" }}}
" {{{ statusline
hi User1 ctermbg=red   ctermfg=black  guibg=red   guifg=black

" " Function: display errors from Ale in statusline
function! LinterStatus() abort
   let l:counts = ale#statusline#Count(bufnr(''))
   let l:all_errors = l:counts.error + l:counts.style_error
   let l:all_non_errors = l:counts.total - l:all_errors
   return l:counts.total == 0 ? '' : printf(
   \ 'W:%d E:%d',
   \ l:all_non_errors,
   \ l:all_errors
   \)
endfunction

set laststatus=2
set statusline=
set statusline+=\ %l
set statusline+=\ %*
set statusline+=\ <<
set statusline+=\ %{pathshorten(expand('%:f'))}\ %*
set statusline+=\ >>
set statusline+=\ %m
set statusline +=\ %{fugitive#statusline()}
set statusline+=%=
set statusline+=%1*%{LinterStatus()}
set statusline+=%0*\ <<
set statusline+=\ ::
set statusline+=\ %n
set statusline+=\ >>\ %*
" }}}
" {{{ Keybindings
" leader key
map <SPACE> <leader>
map <SPACE><SPACE> <leader><leader>

inoremap fd <esc>

" quickly switch to alternate file
nnoremap <leader><leader> <c-^>

" CoC keybindings
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


let g:user_emmet_leader_key = '<c-e>'

" align
" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" fzf - fuzzy file searching
" I will remove c-F once I got used to leader f
map <c-F> :Files<cr>
map <leader>b :Buffers<cr>
map <leader>f :Files<cr>
map <leader>l :Lines<cr>

" ripgrep
map <leader>/ :Rg<cr>

" easymotion
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
" }}}
" {{{ Linting, LanguageServer and Autofixing
" autofix on save
let g:ale_fix_on_save = 1

let g:ale_linters = {
      \ 'rust': ['rls', 'analyzer'],
      \ 'ruby': ['solargraph', 'standardrb', 'rubocop'],
      \ 'python': ['mypy', 'flake8', 'pylint']
      \ }

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'javascript.jsx': ['prettier', 'eslint'],
\   'ruby': ['rubocop'],
\   'python': ['black'],
\   'rust': ['rustfmt'],
\   'go': ['gofmt', 'goimports']
\}

let g:ale_sign_error = '!!'
map <leader>gd :ALEGoToDefinition<cr>
nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)
" }}}
" golang {{{
let g:go_fmt_command="goimports"
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
" see type in the status line
let g:go_auto_type_info = 1
let g:go_metalinter_autosave = 1
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4
"fuzzy search functions and the like
au FileType go nmap <leader>gt :GoDeclsDir<cr>
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <f8>  :DlvToggleBreakpoint<cr>
autocmd FileType go nmap <f5>  :DlvTest<cr>
" }}}
" {{{ javascript
autocmd FileType javascript set fdm=syntax
" }}}
" rust {{{
set hidden
let $RUST_SRC_PATH="/home/oem/src/rust/src/"
autocmd FileType rust set fdm=syntax
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
" {{{ python
let g:black_linelength=79 " this only affects the :Black command
au BufNewFile,BufRead *.py set foldmethod=indent
" }}}
" {{{julia
au VimEnter,BufRead,BufNewFile *.jl set filetype=julia
let cmdline_in_buffer = 0
" }}}
" frontend {{{
" react
let g:user_emmet_settings = {
      \  'javascript.jsx' : {
      \      'extends' : 'jsx',
      \  },
      \}
let g:jsx_ext_required = 0

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
" HTML {{{
let g:html_indent_inctags = "html,body,head,tbody"
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
