local ht = require('haskell-tools')
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }

vim.keymap.set('n', '<leader>ll', vim.lsp.codelens.run, opts)
vim.keymap.set('n', '<leader>ls', ht.hoogle.hoogle_signature, opts)
vim.keymap.set('n', '<leader>le', ht.lsp.buf_eval_all, opts)
vim.keymap.set('n', '<leader>lrr', ht.repl.toggle, opts)
vim.keymap.set('n', '<leader>lrf', function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)
vim.keymap.set('n', '<leader>lrq', ht.repl.quit, opts)
