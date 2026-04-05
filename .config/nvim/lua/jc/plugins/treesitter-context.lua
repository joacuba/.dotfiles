local utils = require("jc.plugins.utils")

vim.pack.add({
	utils.gh("nvim-treesitter/nvim-treesitter-context"),
})

require("treesitter-context").setup({
	enable = true,
})

vim.keymap.set("n", "<leader>tc", "<cmd>TSContext toggle<CR>", { desc = "Toggle treesitter context" })
