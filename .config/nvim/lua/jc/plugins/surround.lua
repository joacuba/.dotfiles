local utils = require("jc.plugins.utils")

vim.pack.add({
	{
		src = utils.gh("nvim-mini/mini.surround"),
		version = "stable",
	},
})

require("mini.surround").setup()
