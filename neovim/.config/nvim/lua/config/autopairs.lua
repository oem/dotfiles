local npairs = require('nvim-autopairs')
npairs.setup({})
npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))

require('nvim-autopairs.completion.cmp').setup({
    map_cr = true,
    insert = false
})

