local map = require("config.utils").map
local options = { silent = true, noremap = true }
local builtin = require("telescope.builtin")

-- files
map("n", "<leader>ff", ":lua require('telescope.builtin').find_files({hidden = true})<cr>", options)
map("n", "<leader>fF", ":lua require('telescope.builtin').git_files({ hidden = true})<cr>", options)
map(
	"n",
	"<leader>fr",
	":lua require('telescope').extensions.frecency.frecency(require('telescope.themes').get_dropdown())<cr>",
	options
)

-- buffers
map(
	"n",
	"<leader>bb",
	":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown())<cr>",
	options
)

-- search
map(
	"n",
	"<leader>ss",
	":lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown())<cr>",
	options
)
map(
	"n",
	"<leader>sb",
	":lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown())<cr>",
	options
)
map(
	"n",
	"<leader>sw",
	":lua require('telescope.builtin').grep_string(require('telescope.themes').get_dropdown())<cr>",
	options
)

-- notes
-- requires ripgrep and fd
map("n", "<leader>ns", ":lua require('oem.telescope').search_notes()<cr>", options)
map("n", "<leader>nf", ":lua require('oem.telescope').find_notes()<cr>", options)

-- help
map(
	"n",
	"<leader>hh",
	":lua require('telescope.builtin').help_tags(require('telescope.themes').get_dropdown())<cr>",
	options
)

-- LSP
vim.keymap.set("n", "<leader>le", function()
	builtin.diagnostics(require("telescope.themes").get_dropdown({ bufnr = 0 }))
end, { desc = "Telescope LSP diagnostics (buffer)" })

vim.keymap.set("n", "<leader>lE", function()
	builtin.diagnostics(require("telescope.themes").get_dropdown({}))
end, { desc = "Telescope LSP diagnostics" })

vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "Telescope LSP references" })
vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Telescope LSP symbols (document)" })
vim.keymap.set("n", "<leader>lS", builtin.lsp_workspace_symbols, { desc = "Telescope LSP symbols" })
vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, { desc = "Telescope LSP definitions" })
vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, { desc = "Telescope LSP implementations" })

map("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<cr>", options)

-- treesitter
map(
	"n",
	"<leader>t",
	":lua require('telescope.builtin').treesitter(require('telescope.themes').get_dropdown())<cr>",
	options
)
