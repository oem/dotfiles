" vim:fdm=marker

" plugins {{{
call plug#begin('~/.vim/bundle')
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

" comments
Plug 'jbgutierrez/vim-better-comments'
Plug 'tomtom/tcomment_vim'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" python
Plug 'ambv/black'

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

" orgmode
Plug 'vim-scripts/utl.vim'
Plug 'inkarkat/vim-SyntaxRange'
Plug 'jceb/vim-orgmode'

" markdown
Plug 'tpope/vim-markdown'

" api blueprint
Plug 'kylef/apiblueprint.vim'

" auto complete and other insert mode completions, like snippets
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" auto completion for go
Plug 'zchee/deoplete-go', { 'do': 'make'}
" ES2015 code snippets (Optional)
Plug 'epilande/vim-es2015-snippets'
" React code snippets
Plug 'epilande/vim-react-snippets'
" Ultisnips
Plug 'SirVer/ultisnips'
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'
Plug 'Shougo/echodoc'

Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh'
  \ }

" themes
Plug 'joshdick/onedark.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'tomasiser/vim-code-dark'
Plug 'KimNorgaard/vim-frign'
Plug 'nickaroot/vim-xcode-dark-theme'

Plug 'jamessan/vim-gnupg'
Plug 'nacitar/terminalkeys.vim'
Plug 'tpope/vim-dispatch'
Plug 'christoomey/vim-tmux-navigator'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" improved incsearch
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

Plug 'sbdchd/neoformat'
call plug#end()
" }}}
" plugins config {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
      \ 'tern#Complete',
      \ 'jspc#omni'
      \]

" LINTING
" language client
let g:LanguageClient_serverCommands = {
      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
      \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
      \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
      \ 'python': ['~/.pyenv/shims/pyls'],
      \ 'ruby': ['tcp://localhost:7658']
      \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>

" close the preview window after completion is done
autocmd CompleteDone * silent! pclose!

let g:LanguageClient_diagnosticsDisplay = {
  \1: {'name': 'Error', 'texthl': 'ALEError', 'signText': 'X', 'signTexthl': 'ALEErrorSign',},
  \2: {'name': 'Warning', 'texthl': 'ALEWarning', 'signText': '!', 'signTexthl': 'ALEWarningSign',},
  \3: {'name': 'Information', 'texthl': 'ALEInfo', 'signText': 'ℹ', 'signTexthl': 'ALEInfoSign',},
  \4: {'name': 'Hint', 'texthl': 'ALEInfo', 'signText': 'i', 'signTexthl': 'ALEInfoSign',},
  \}

" ale
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '!'
" Enable integration with airline.
" let g:airline#extensions#ale#enabled = 1

" orgmode
:let g:org_agenda_files=['~/org/*.org', '~/org/projects/*.org']

" folding
set nofoldenable

let g:UltiSnipsExpandTrigger="<C-k>"

" AUTOFORMATTING
" neoformat on save
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END

" neomake
" autocmd! BufWritePost * Neomake
" let g:neomake_error_sign = {'text': '●', 'texthl': 'NeomakeErrorSign'}

set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'

" incsearch
map /f <Plug>(incsearch-fuzzy-/)
map ?f <Plug>(incsearch-fuzzy-?)
map g/ <Plug>(incsearch-fuzzy-stay)

"easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-s2)
nmap s <Plug>(easymotion-overwin-f)
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

" neoformat
let g:neoformat_only_msg_on_error = 1 " less verbose

" fold fish files and vim files initially
au BufReadPost,BufNewFile .vimrc,vimrc,*.fish normal zM
" }}}
" {{{ ui
set  background=dark
" set termguicolors
" colo PaperColor
" colo onedark
colo xcode_dark
" let g:airline#extensions#tabline#enabled = 1
" different highlight color
" hi Search ctermfg=0 ctermbg=4
" hide the empty buffer character
" highlight EndOfBuffer ctermfg=bg

hi VertSplit ctermfg=None ctermbg=None guifg=None guibg=None
" hi VertSplit ctermfg=237 ctermbg=237 cterm=bold
hi CursorLine ctermbg=None
" hi Normal guibg=NONE ctermbg=NONE
hi StatusLine ctermbg=0 ctermfg=16 guibg=#333333

" gitgutter
hi GitGutterAdd          ctermfg=2   ctermbg=2  guifg=#718c00 guibg=#718c00
hi GitGutterChange       ctermfg=5   ctermbg=5  guifg=#8959a8 guibg=#8959a8
hi GitGutterDelete       ctermfg=1   ctermbg=1  guifg=#d75e00 guibg=#d75e00
hi GitGutterChangeDelete ctermfg=13  ctermbg=13 guifg=#d6225e guibg=#d6225e
set updatetime=100

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
" hi User1 ctermbg=red   ctermfg=black  guibg=red   guifg=black
"
" " Function: display errors from Ale in statusline
" function! LinterStatus() abort
"    let l:counts = ale#statusline#Count(bufnr(''))
"    let l:all_errors = l:counts.error + l:counts.style_error
"    let l:all_non_errors = l:counts.total - l:all_errors
"    return l:counts.total == 0 ? '' : printf(
"    \ 'W:%d E:%d',
"    \ l:all_non_errors,
"    \ l:all_errors
"    \)
" endfunction
"
" set laststatus=2
" set statusline=
" set statusline+=\ %l
" set statusline+=\ %*
" set statusline+=\ ‹‹
" set statusline+=\ %f\ %*
" set statusline+=\ ››
" set statusline+=\ %m
" set statusline +=\ %{fugitive#statusline()}
" set statusline+=%=
" set statusline+=%1*%{LinterStatus()}
" set statusline+=%0*\ ‹‹
" set statusline+=\ ::
" set statusline+=\ %n
" set statusline+=\ ››\ %*
" }}}
" {{{ Keybindings
" leader key
map <SPACE> <leader>
map <SPACE><SPACE> <leader><leader>

inoremap fd <esc>

" quickly switch to alternate file
nnoremap <leader><leader> <c-^>

let g:user_emmet_leader_key = '<c-e>'

" align
" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" vimux
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
" Zoom the tmux runner pane
map <Leader>vz :VimuxZoomRunner<CR>
" Zoom the tmux runner pane
map <Leader>vc :VimuxCloseRunner<CR>

" fzf - fuzzy file searching
" I will remove c-F once I got used to leader f
map <c-F> :FZF<cr>
map <leader>b :Buffers<cr>
map <leader>f :Files<cr>
map <leader>l :Lines<cr>

" ripgrep
map <leader>/ :Rg<cr>

" fugitive: git
map <leader>gs :Gstatus<cr>
map <leader>gd :Gdiff<cr>
map <leader>gp :Gpush<cr>

" easymotion
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
" }}}
" golang {{{
let g:go_fmt_command="goimports"
let g:ale_linters = {'go': ['gometalinter', 'gofmt']}
let g:ale_go_gometalinter_options = '--fast'
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
let g:go_list_type = "quickfix"
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
let g:neoformat_enabled_javascript = ['prettiereslint']
autocmd FileType javascript set fdm=syntax
" }}}
" rust {{{
set hidden
let $RUST_SRC_PATH="/home/oem/src/rust/src/"
autocmd FileType rust set fdm=syntax
" disable ale linting for rust since we are already using the RLS for that
let g:ale_linters = { 'rust': [] }
" }}}
" ruby {{{
let g:rails_default_file='config/database.yml'

let g:neoformat_ruby_rubocop = {
      \ 'exe': 'bundle',
      \ 'args': ['exec', 'rubocop', '--auto-correct', '--stdin', '"%:p"', '2>/dev/null', '|', 'sed "1,/^====================$/d"'],
      \ 'stdin': 1,
      \ 'stderr': 1
      \ }


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
let g:neoformat_enabled_python = ['yapf', 'autopep8']
let g:black_linelength=79 " this only affects the :Black command
let g:ale_linters = { 'python': [] }
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

source ~/dotfiles/vim/statusline.vim
