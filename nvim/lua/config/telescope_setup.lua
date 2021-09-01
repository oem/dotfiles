local map = require('config.utils').map
local silent = { silent = true }

map('n', '<leader>f', [[<cmd>Telescope find_files theme=get_dropdown<cr>]], silent)
map('n', '<leader>r', [[<cmd>Telescope frecency theme=get_dropdown<cr>]], silent)
map('n', '<leader>s', [[<cmd>Telescope live_grep theme=get_dropdown<cr>]], silent)
map('n', '<leader>le', [[<cmd>Telescope lsp_workspace_diagnostics theme=get_dropdown<cr>]], silent)
map('n', '<leader>t', [[<cmd>Telescope treesitter theme=get_dropdown<cr>]], silent)
map('n', '<leader>b', [[<cmd>Telescope buffers show_all_buffers=true theme=get_dropdown<cr>]], silent)
