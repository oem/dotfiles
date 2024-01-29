require('gitsigns').setup {
    signs = {
        add = { hl = 'GreenSign', text = '│', numhl = 'GitSignsAddNr' },
        change = { hl = 'BlueSign', text = '│', numhl = 'GitSignsChangeNr' },
        delete = { hl = 'RedSign', text = '│', numhl = 'GitSignsDeleteNr' },
        topdelete = { hl = 'RedSign', text = '│', numhl = 'GitSignsDeleteNr' },
        changedelete = { hl = 'PurpleSign', text = '│', numhl = 'GitSignsChangeNr' },
    },
    signcolumn = true,
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']g', function()
            if vim.wo.diff then return ']g' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '[g', function()
            if vim.wo.diff then return '[g' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })
    end
}
