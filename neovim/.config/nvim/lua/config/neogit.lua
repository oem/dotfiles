local map = require('config.utils').map
local options = {silent = true, noremap = true}

map('n', '<leader>vv', [[<cmd>Neogit<cr>]], options)
map('n', '<leader>vb', [[<cmd>Git blame<cr>]], options)

