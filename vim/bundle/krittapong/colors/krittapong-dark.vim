" krittapong-dark - theme by oem

let g:colors_name="krittapong-dark"
hi clear
set background=dark

hi Normal   ctermfg=15 ctermbg=233

" complete menu
hi Pmenu           ctermfg=137 ctermbg=232 cterm=none
hi PmenuSel        ctermfg=196 ctermbg=235 cterm=bold
hi PmenuSbar       ctermfg=000 ctermbg=233 cterm=none
hi PmenuThumb      ctermfg=137 ctermbg=000 cterm=none

hi PreCondit       ctermfg=118             cterm=bold
hi PreProc         ctermfg=218
hi Question        ctermfg=81
hi Repeat          ctermfg=161             cterm=bold
hi Search          ctermfg=234 ctermbg=222

" git gutter
hi GitGutterAdd          ctermfg=2   ctermbg=2
hi GitGutterChange       ctermfg=5   ctermbg=5
hi GitGutterDelete       ctermfg=1   ctermbg=1
hi GitGutterChangeDelete ctermfg=13  ctermbg=13

" ui decorations
hi StatusLine      ctermfg=5   ctermbg=233
hi StatusLineNC    ctermfg=5   ctermbg=233
hi VertSplit       ctermfg=236 ctermbg=236 cterm=bold
hi VisualNOS                   ctermbg=238
hi Visual                      ctermbg=237
hi WarningMsg      ctermfg=9   ctermbg=238 cterm=bold
hi WildMenu        ctermfg=13  ctermbg=233

hi LineNr          ctermfg=238 ctermbg=233
hi CursorLineNr    ctermfg=245 ctermbg=234

" hide the tilde symbol/empty buffer area
hi NonText         ctermfg=236
hi CursorLine                  ctermbg=234 cterm=none

" diff
hi DiffAdd                     ctermbg=24
hi DiffChange      ctermfg=181 ctermbg=239
hi DiffDelete      ctermfg=162 ctermbg=53
hi DiffText                    ctermbg=102 cterm=bold

" syntax
hi Comment         ctermfg=241

hi Boolean         ctermfg=15
hi Character       ctermfg=15
hi Number          ctermfg=15
hi String          ctermfg=2
hi Conditional     ctermfg=15               cterm=bold
hi Constant        ctermfg=15               cterm=bold
hi Cursor          ctermfg=15  ctermbg=253
hi Debug           ctermfg=15               cterm=bold
hi Define          ctermfg=15
hi Delimiter       ctermfg=15

hi DiffAdd                     ctermbg=24
hi DiffChange      ctermfg=15  ctermbg=239
hi DiffDelete      ctermfg=15  ctermbg=53
hi DiffText                    ctermbg=102   cterm=bold

hi Directory       ctermfg=15               cterm=bold
hi Error           ctermfg=15  ctermbg=89
hi ErrorMsg        ctermfg=15  ctermbg=16    cterm=bold
hi Exception       ctermfg=15               cterm=bold
hi Float           ctermfg=15
hi FoldColumn      ctermfg=15  ctermbg=233 cterm=none
hi Folded          ctermfg=15  ctermbg=235 cterm=bold
hi Function        ctermfg=25
hi Identifier      ctermfg=15
hi Ignore          ctermfg=15  ctermbg=232
hi IncSearch       ctermfg=15  ctermbg=16

hi Keyword         ctermfg=15               cterm=bold
hi Label           ctermfg=15               cterm=none
hi Macro           ctermfg=15
hi SpecialKey      ctermfg=13

hi MatchParen      ctermfg=15  ctermbg=234   cterm=none
hi ModeMsg         ctermfg=15
hi MoreMsg         ctermfg=15
hi Operator        ctermfg=15

" marks column
hi SignColumn      ctermfg=15 ctermbg=235
hi SpecialChar     ctermfg=15               cterm=bold
hi SpecialComment  ctermfg=15               cterm=bold
hi Special         ctermfg=15 ctermbg=232

hi SpellBad        ctermfg=15 ctermbg=233  cterm=bold
hi SpellCap        ctermfg=15 ctermbg=233  cterm=bold
hi SpellRare       ctermfg=15 ctermbg=233  cterm=bold
hi SpellLocal      ctermfg=15 ctermbg=235  cterm=bold

hi Statement       ctermfg=15               cterm=bold
hi StorageClass    ctermfg=15
hi Structure       ctermfg=15
hi Tag             ctermfg=15
hi Title           ctermfg=15
hi Todo            ctermfg=15 ctermbg=233   cterm=bold

hi Typedef         ctermfg=15
hi Type            ctermfg=12               cterm=none
hi Underlined      ctermfg=15               cterm=none

hi TabLine         ctermfg=100 ctermbg=233
hi TabLineFill     ctermfg=233 ctermbg=233
hi TabLineSel      ctermfg=220 ctermbg=234

