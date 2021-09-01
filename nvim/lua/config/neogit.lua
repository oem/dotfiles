local map = require('config.utils').map
local silent = { silent = true }

map('n', '<leader>gg', [[<cmd>Neogit<cr>]], silent)
map('n', '<leader>gb', [[<cmd>Git blame<cr>]], silent)

