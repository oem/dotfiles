local map = require('config.utils').map
local options = {silent = true, noremap = true}

-- files
map('n', '<leader>ff',
    [[<cmd>Telescope find_files theme=get_dropdown hidden=true<cr>]], options)
map('n', '<leader>fF', [[<cmd>Telescope git_files theme=get_dropdown<cr>]],
    options)
map('n', '<leader>fr', [[<cmd>Telescope frecency theme=get_dropdown<cr>]],
    options)

-- buffers
map('n', '<leader>bb',
    [[<cmd>Telescope buffers show_all_buffers=true theme=get_dropdown<cr>]],
    options)

-- search
map('n', '<leader>ss', [[<cmd>Telescope live_grep theme=get_dropdown<cr>]],
    options)
map('n', '<leader>sb',
    [[<cmd>Telescope current_buffer_fuzzy_find theme=get_dropdown<cr>]], options)
map('n', '<leader>sw', [[<cmd>Telescope grep_string theme=get_dropdown<cr>]],
    options)

-- notes
map('n', '<leader>nn', ":lua require('oem.telescope').search_notes()<cr>",
    options)
map('n', '<leader>nf', ":lua require('oem.telescope').find_notes()<cr>", options)

-- help
map('n', '<leader>hh', [[<cmd>Telescope help_tags<cr>]], options)

-- LSP
map('n', '<leader>le', [[<cmd>Telescope diagnostics theme=get_dropdown<cr>]],
    options)
map('n', '<leader>t', [[<cmd>Telescope treesitter theme=get_dropdown<cr>]],
    options)
map('n', '<leader>lr', [[<cmd>Telescope lsp_references theme=get_dropdown<cr>]],
    options)
map('n', '<leader>ld',
    [[<cmd>Telescope lsp_definitions theme=get_dropdown<cr>]], options)
map('n', '<leader>li',
    [[<cmd>Telescope lsp_implementations theme=get_dropdown<cr>]], options)
map('n', '<leader>la',
    [[<cmd>Telescope lsp_range_code_actions theme=get_dropdown<cr>]], options)
