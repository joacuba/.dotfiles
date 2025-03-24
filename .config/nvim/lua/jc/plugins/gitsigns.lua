return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({ word_diff = true })
		vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { desc = "Show git diff" })
	end,
}
