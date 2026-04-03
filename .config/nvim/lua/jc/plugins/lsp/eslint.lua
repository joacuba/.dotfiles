local utils = require("jc.plugins.utils")

vim.pack.add({
	utils.gh("esmuellert/nvim-eslint"),
})

-- Initialize eslint
require("nvim-eslint").setup({})
