vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#cf001e" })
vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#cf001e" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#505050" })
vim.api.nvim_set_hl(0, "SnacksPickerListCursorLine", { bg = "#ffffff", fg = "#08080C", bold = true })
vim.api.nvim_set_hl(0, "QuickFixLine", { bg = "#ffffff", fg = "#08080C", bold = true })
vim.api.nvim_set_hl(0, "Folded", { bg = "#303030", fg = "#08080C", bold = true })

-- unfocused lines
vim.api.nvim_set_hl(0, "NeogitDiffAdd", { fg = "#ffffff", bg = "#007c4c" })
vim.api.nvim_set_hl(0, "NeogitDiffDelete", { fg = "#ffffff", bg = "#cf001e" })
vim.api.nvim_set_hl(0, "NeogitDiffContext", { bg = "NONE" })

-- lines in the hunk under the cursor
vim.api.nvim_set_hl(0, "NeogitDiffAddHighlight", { fg = "#ffffff", bg = "#007c4c" })
vim.api.nvim_set_hl(0, "NeogitDiffDeleteHighlight", { fg = "#ffffff", bg = "#cf001e" })
vim.api.nvim_set_hl(0, "NeogitDiffContextHighlight", { bg = "#2a2a37" })
