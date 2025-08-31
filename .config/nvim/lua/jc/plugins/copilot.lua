return {
	"github/copilot.vim",
	event = "InsertEnter",
	config = function()
		vim.keymap.set("n", "<leader>ce", function()
			vim.cmd("Copilot enable")
		end, { desc = "Enable Copilot" })

		vim.keymap.set("n", "<leader>cd", function()
			vim.cmd("Copilot disable")
		end, { desc = "Disable Copilot" })

		vim.keymap.set("n", "<leader>cs", function()
			vim.cmd("Copilot status")
		end, { desc = "Copilot Status" })
	end,
}
