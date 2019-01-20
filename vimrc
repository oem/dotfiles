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
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'

Plug 'neomake/neomake'

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

Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'rust-lang/rust.vim'
Plug 'majutsushi/tagbar'
Plug 'Shougo/echodoc'

Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh'
  \ }

Plug 'jamessan/vim-gnupg'
Plug 'nacitar/terminalkeys.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-dispatch'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'

Plug 'fatih/vim-go'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'

Plug 'joshdick/onedark.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'tomasiser/vim-code-dark'

" using ranger in neovim
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'

" improved incsearch
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

" markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" typescript
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/vim-js-pretty-template'

Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }

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

" language client
let g:LanguageClient_serverCommands = {
      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
      \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
      \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
      \ 'python': ['~/.pyenv/shims/pyls'],
      \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>

" align
" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" folding
set nofoldenable

let g:UltiSnipsExpandTrigger="<C-k>"

" neoformat on save
au BufWrite * :Neoformat

nmap <F8> :TagbarToggle<CR>

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

" neomake
" autocmd! BufWritePost * Neomake
" let g:neomake_error_sign = {'text': '●', 'texthl': 'NeomakeErrorSign'}

" fzf - fuzzy file searching
map <c-F> :FZF<cr>

" incsearch
map /f <Plug>(incsearch-fuzzy-/)
map ?f <Plug>(incsearch-fuzzy-?)
map g/ <Plug>(incsearch-fuzzy-stay)

"easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-s2)
nmap s <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

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

" typescript
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
let g:tsuquyomi_completion_detail = 1
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
let g:tsuquyomi_single_quote_import=1
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
set number

" regexp like perl
"nnoremap / /\v

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

" set t_Co=256
" if (has("nvim"))
"   "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"   let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" endif
" "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
" "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
" if (has("termguicolors"))
" set termguicolors
" endif
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"
set  background=dark
" colo PaperColor
colo onedark
" let g:airline#extensions#tabline#enabled = 1
" different highlight color
" hi Search ctermfg=0 ctermbg=4

" hide the empty buffer character
highlight EndOfBuffer ctermfg=bg

" hi VertSplit ctermfg=None ctermbg=None
" hi VertSplit ctermfg=237 ctermbg=237 cterm=bold
hi CursorLine ctermbg=None
" hi Normal guibg=NONE ctermbg=NONE
" hi StatusLine ctermbg=None

" gitgutter
hi GitGutterAdd          ctermfg=2   ctermbg=2
hi GitGutterChange       ctermfg=5   ctermbg=5
hi GitGutterDelete       ctermfg=1   ctermbg=1
hi GitGutterChangeDelete ctermfg=13  ctermbg=13
set updatetime=100

" show invisibles
set fillchars+=vert:\ ,eob:\ ,fold:·
set list
set listchars=tab:»\ ,eol:«
map <F4> :noh<CR>
" shows a dollar sign at the end of a change range
set cpo+=$

inoremap jj <esc>
imap <leader><cr> <esc>o
" quickly switch to alternate file
nnoremap <leader><leader> <c-^>

" clipboard
set clipboard+=unnamed

" leader key
map <SPACE> <leader>
map <SPACE><SPACE> <leader><leader>

" cursor highlighting
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" statusbar
set statusline=[%02n]%y\ %f\ %(\[%M%R%H]%)\ %{fugitive#statusline()\ }%=\ %4l,%02c%2V\ %P%*
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
map <Leader>r :call RunNearestSpec()<CR>
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
" }}}
" {{{ javascript
function! neoformat#formatters#javascript#prettiereslint() abort
    return {
        \ 'exe': 'prettier-eslint',
        \ 'args': ['--stdin', '--single-quote true'],
        \ 'stdin': 1,
        \ }
endfunction
let g:neoformat_enabled_javascript = ['prettiereslint']
autocmd FileType javascript set fdm=syntax
" }}}
" rust {{{
let g:rustfmt_autosave = 1
set hidden
let g:racer_cmd = "/home/oem/.cargo/bin/racer"
let $RUST_SRC_PATH="/home/oem/src/rust/src/"
autocmd FileType rust set fdm=syntax
" disable ale linting for rust since we are already using the RLS for that
let g:ale_linters = { 'rust': [] }
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
" ripgrep {{{
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
" }}}
