local utils = require("jc.plugins.utils")

vim.pack.add({
	utils.gh("szw/vim-maximizer"),
})

-- keymaps
vim.keymap.set("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", { desc = "Split Window Max or Minimize" })
