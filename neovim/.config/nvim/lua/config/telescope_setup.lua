local map = require('config.utils').map
local silent = { silent = true }
local noremap = { noremap = true }

map('n', '<leader>F', [[<cmd>Telescope find_files theme=get_dropdown<cr>]], silent)
map('n', '<leader>f', [[<cmd>Telescope git_files theme=get_dropdown<cr>]], silent)
map('n', '<leader>r', [[<cmd>Telescope frecency theme=get_dropdown<cr>]], silent)
map('n', '<leader>s', [[<cmd>Telescope live_grep theme=get_dropdown<cr>]], silent)
map('n', '<leader>le', [[<cmd>Telescope lsp_workspace_diagnostics theme=get_dropdown<cr>]], silent)
map('n', '<leader>t', [[<cmd>Telescope treesitter theme=get_dropdown<cr>]], silent)
map('n', '<leader>b', [[<cmd>Telescope buffers show_all_buffers=true theme=get_dropdown<cr>]], silent)
map('n', '<leader>lr', [[<cmd>Telescope lsp_references theme=get_dropdown<cr>]], noremap)
map('n', '<leader>ld', [[<cmd>Telescope lsp_definitions theme=get_dropdown<cr>]], noremap)
map('n', '<leader>li', [[<cmd>Telescope lsp_implementations theme=get_dropdown<cr>]], noremap)
map('n', '<leader>ps', [[<cmd>Telescope grep_string theme=get_dropdown<cr>]], noremap)
map('n', '<leader>df', [[<cmd>Telescope grep_string theme=get_dropdown<cr>]], noremap)
