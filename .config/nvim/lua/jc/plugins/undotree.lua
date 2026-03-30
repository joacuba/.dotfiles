local utils = require("jc.plugins.utils")

vim.pack.add({
	utils.gh("mbbill/undotree"),
})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
