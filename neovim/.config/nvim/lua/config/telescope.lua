local actions = require('telescope.actions')
local telescope = require 'telescope'
local open_with_trouble = require("trouble.sources.telescope").open

telescope.setup {
    defaults = {
        color_devicons = true,
        -- file_ignore_patterns = { "node_modules", ".git" },
        vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case", "--hidden"
        },
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<c-t>"] = open_with_trouble
            },
            n = { ["<c-t>"] = open_with_trouble }
        },
        layout_strategy = 'flex',
        scroll_strategy = 'cycle'
    },
    extensions = {
        frecency = { workspaces = { exo = '/home/oem/src' } },
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case'
        }
    },
    pickers = {
        lsp_references = { theme = 'dropdown' },
        lsp_code_actions = { theme = 'dropdown' },
        lsp_definitions = { theme = 'dropdown' },
        lsp_implementations = { theme = 'dropdown' },
        find_files = { theme = 'dropdown' },
        git_files = { theme = 'dropdown' },
        buffers = { sort_lastused = true, previewer = false }
    }
}

-- Extensions
telescope.load_extension 'frecency'
telescope.load_extension 'fzf'
