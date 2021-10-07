require'nvim-treesitter.configs'.setup({
    playground = {
        enable = true
    },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"}
    },
    ensure_installed = "maintained",
    highlight = {
        enable = true
    },
    autopairs = {
        enable = true
    },
    refactor = {
        highlight_definitions = {
            enable = true
        },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr"
            }
        }
    }
})
