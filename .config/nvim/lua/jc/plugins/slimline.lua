local utils = require("jc.plugins.utils")

vim.pack.add({
	utils.gh("sschleemilch/slimline.nvim"),
})

require("slimline").setup({
	style = "fg",
	bold = true,
	configs = {
		path = {
			trunc_width = 100,
			-- disable truncate the directory
			truncate = false,
			hl = {
				primary = "Label",
			},
		},
		git = {
			hl = {
				primary = "Function",
			},
		},
		filetype_lsp = {
			hl = {
				primary = "String",
			},
		},
	},
})
