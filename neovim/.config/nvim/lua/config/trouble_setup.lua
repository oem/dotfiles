local map = require('config.utils').map
local noremap = {
    noremap = true
}

map('n', '<leader>xx', [[<cmd>TroubleToggle<cr>]], noremap)
map('n', '<leader>xd', [[<cmd>TroubleToggle document_diagnostics<cr>]],
    noremap)
map('n', '<leader>xw', [[<cmd>TroubleToggle workspace_diagnostics<cr>]],
    noremap)
