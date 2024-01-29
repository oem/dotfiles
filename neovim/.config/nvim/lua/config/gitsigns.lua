local map = require('config.utils').map

require('gitsigns').setup {
    signs = {
        add = { hl = 'GreenSign', text = '│', numhl = 'GitSignsAddNr' },
        change = { hl = 'BlueSign', text = '│', numhl = 'GitSignsChangeNr' },
        delete = { hl = 'RedSign', text = '│', numhl = 'GitSignsDeleteNr' },
        topdelete = { hl = 'RedSign', text = '│', numhl = 'GitSignsDeleteNr' },
        changedelete = { hl = 'PurpleSign', text = '│', numhl = 'GitSignsChangeNr' },
    },
    signcolumn = true,
    map('n', ']g', '<cmd>lua require"gitsigns".next_hunk()<cr>'),
    map('n', '[g', '<cmd>lua require"gitsigns"._prev_hunk()<cr>')
}
