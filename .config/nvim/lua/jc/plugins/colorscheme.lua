local utils = require("jc.plugins.utils")

vim.pack.add({
	{
		src = utils.gh("rose-pine/neovim"),
		name = "rose-pine",
	},
})

require("rose-pine").setup({
	dark_variant = "moon",
	palette = {
		moon = {
			base = "#1A1A1A",
			surface = "#1A1A1A",
		},
		dawn = {
			base = "#FFFFFF",
			surface = "#FFFFFF",
		},
	},
})

vim.cmd("colorscheme rose-pine")
