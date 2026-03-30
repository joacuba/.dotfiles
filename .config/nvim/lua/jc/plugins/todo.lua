local utils = require("jc.plugins.utils")

vim.pack.add({
	utils.gh("folke/todo-comments.nvim"),
})

require("todo-comments").setup({})
