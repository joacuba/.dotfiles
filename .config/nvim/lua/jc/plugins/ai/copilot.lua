local utils = require("jc.plugins.utils")

vim.pack.add({
	utils.gh("github/copilot.vim"),
})

vim.filetype.add({
	filename = {
		[".env"] = "dotenv",
	},
})

vim.g.copilot_filetypes = {
	dotenv = false,
}
