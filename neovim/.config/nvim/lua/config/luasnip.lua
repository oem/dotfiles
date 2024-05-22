local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node

ls.setup({})

vim.cmd [[
  imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
  imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
  snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
  snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
]]

ls.add_snippets(
    "agda", {
        s("fa", {
            t("∀"),
        }),
        s("te", {
            t("∃"),
        }),
        s("arr", {
            t("→"),
        }),
        s("lmb", {
            t("λ"),
        }),
        s("tri", {
            t("≡"),
        }),
        s("not", {
            t("¬"),
        }),
    }
)
