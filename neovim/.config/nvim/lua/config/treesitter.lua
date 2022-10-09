require'nvim-treesitter.configs'.setup({
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer"
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer"
            }
        }
    },
    playground = {enable = true},
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"}
    },
    highlight = {enable = true},
    autopairs = {enable = true},
    refactor = {
        highlight_definitions = {enable = true},
        smart_rename = {enable = true, keymaps = {smart_rename = "grr"}}
    }
})
