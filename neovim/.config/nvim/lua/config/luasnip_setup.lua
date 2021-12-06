local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.snippets = {all = {s("expand", t "expanded")}}

