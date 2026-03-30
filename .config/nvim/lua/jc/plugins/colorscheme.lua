local utils = require("jc.plugins.utils")

vim.pack.add({
	{
		src = utils.gh("rose-pine/neovim"),
		name = "rose-pine",
	},
})

require("rose-pine").setup({
	variant = "pine",
})

vim.cmd("colorscheme rose-pine")
