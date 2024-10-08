local map = require('config.utils').map
local options = { silent = true, noremap = true }

-- files
map('n', '<leader>ff',
    ":lua require('telescope.builtin').find_files({hidden = true})<cr>",
    options)
map('n', '<leader>fF',
    ":lua require('telescope.builtin').git_files({ hidden = true})<cr>",
    options)
map('n', '<leader>fr',
    ":lua require('telescope').extensions.frecency.frecency(require('telescope.themes').get_dropdown())<cr>",
    options)

-- buffers
map('n', '<leader>bb',
    ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown())<cr>",
    options)

-- search
map('n', '<leader>ss',
    ":lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown())<cr>",
    options)
map('n', '<leader>sb',
    ":lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown())<cr>",
    options)
map('n', '<leader>sw',
    ":lua require('telescope.builtin').grep_string(require('telescope.themes').get_dropdown())<cr>",
    options)

-- notes
-- requires ripgrep and fd
map('n', '<leader>ns', ":lua require('oem.telescope').search_notes()<cr>",
    options)
map('n', '<leader>nf', ":lua require('oem.telescope').find_notes()<cr>", options)

-- help
map('n', '<leader>hh',
    ":lua require('telescope.builtin').help_tags(require('telescope.themes').get_dropdown())<cr>",
    options)

-- LSP
map('n', '<leader>g',
    ":lua require('telescope.builtin').diagnostics(require('telescope.themes').get_dropdown({bufnr=0}))<cr>",
    options)
map('n', '<leader>G',
    ":lua require('telescope.builtin').diagnostics(require('telescope.themes').get_dropdown())<cr>",
    options)
map('n', '<leader>r',
    ":lua require('telescope.builtin').lsp_references(require('telescope.themes').get_dropdown())<cr>",
    options)
map('n', '<leader>a',
    ":lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_dropdown())<cr>",
    options)
map('n', '<leader>A',
    ":lua require('telescope.builtin').lsp_workspace_symbols(require('telescope.themes').get_dropdown())<cr>",
    options)
map('n', '<leader>d',
    ":lua require('telescope.builtin').lsp_definitions(require('telescope.themes').get_dropdown())<cr>",
    options)
map('n', '<leader>i',
    ":lua require('telescope.builtin').lsp_implementations(require('telescope.themes').get_dropdown())<cr>",
    options)
map('n', '<leader>c', ":lua vim.lsp.buf.code_action()<cr>", options)

-- treesitter
map('n', '<leader>t',
    ":lua require('telescope.builtin').treesitter(require('telescope.themes').get_dropdown())<cr>",
    options)
