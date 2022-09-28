local map = require('config.utils').map
local options = {silent = true, noremap = true}

map('n', '<leader>gg', [[<cmd>Neogit<cr>]], options)
map('n', '<leader>gb', [[<cmd>Git blame<cr>]], options)

