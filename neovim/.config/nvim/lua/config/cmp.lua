local cmp = require("cmp")
local ls = require("luasnip")
local lspkind = require("lspkind")

cmp.setup({
	formatting = { format = lspkind.cmp_format() },
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<cr>"] = cmp.mapping.confirm(),
		["<tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		["<s-tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
	},
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
	},
})

cmp.setup.filetype({ "sql" }, {
	sources = {
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
	},
})
