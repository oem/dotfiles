local map = require('config.utils').map
local noremap = {
    noremap = true
}

map('n', '<leader>xx', [[<cmd>TroubleToggle<cr>]], noremap)
map('n', '<leader>xd', [[<cmd>TroubleToggle lsp_document_diagnostics<cr>]],
    noremap)
map('n', '<leader>xw', [[<cmd>TroubleToggle lsp_workspace_diagnostics<cr>]],
    noremap)
