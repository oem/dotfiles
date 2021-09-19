local map = require('config.utils').map
local silent = { silent = true }

map('n', '<leader>ff', [[<cmd>Telescope find_files theme=get_dropdown<cr>]], silent)
map('n', '<leader>fg', [[<cmd>Telescope git_files theme=get_dropdown<cr>]], silent)
map('n', '<leader>fr', [[<cmd>Telescope frecency theme=get_dropdown<cr>]], silent)
map('n', '<leader>s', [[<cmd>Telescope live_grep theme=get_dropdown<cr>]], silent)
map('n', '<leader>le', [[<cmd>Telescope lsp_workspace_diagnostics theme=get_dropdown<cr>]], silent)
map('n', '<leader>t', [[<cmd>Telescope treesitter theme=get_dropdown<cr>]], silent)
map('n', '<leader>b', [[<cmd>Telescope buffers show_all_buffers=true theme=get_dropdown<cr>]], silent)
map('n', '<leader>lr', '<cmd>Telescope lsp_references<cr>')
map('n', '<leader>ld', '<cmd>Telescope lsp_definitions<cr>')
map('n', '<leader>li', '<cmd>Telescope lsp_implementations<cr>')
