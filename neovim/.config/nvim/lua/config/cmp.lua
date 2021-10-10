local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end
    },
    mapping = {
        ['<cr>'] = cmp.mapping.confirm(),
        ['<tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
        ['<s-tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})
    },
    sources = {
        {
            name = 'buffer'
        }, {
            name = 'nvim_lsp'
        }, {
            name = 'nvim_lua'
        }, {
            name = 'path'
        }, {
            name = 'luasnip'
        }, {
            name = 'orgmode'
        }
    }
}
