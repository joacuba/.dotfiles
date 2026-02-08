return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gs", function()
			vim.cmd("Git status")
		end, { desc = "See git status" })

		vim.keymap.set("n", "<leader>gp", function()
			vim.cmd("Git push")
		end, { desc = "git push" })

		vim.keymap.set("n", "<leader>gc", function()
			vim.cmd("Git commit")
		end, { desc = "git commit" })

		vim.keymap.set("n", "<leader>go", function()
			vim.cmd("Git")
		end, { desc = "Open fugitive (git)" })
	end,
}
