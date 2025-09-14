return {
	"augmentcode/augment.vim",
	cmd = "Augment",
	init = function()
		local workspace_folders = require("jc.core.augment-code-workspace-folders")
		vim.g.workspace_folders = workspace_folders
	end,
	config = function()
		vim.keymap.set("n", "<leader>at", function()
			vim.cmd("Augment chat-toggle")
		end, { desc = "Toggle augmentcode chat" })

		vim.keymap.set("n", "<leader>as", function()
			vim.cmd("Augment status")
		end, { desc = "Agumentcode status" })

		vim.keymap.set("n", "<leader>ac", function()
			vim.cmd("Augment chat")
		end, { desc = "Agumentcode chat" })

		vim.keymap.set("n", "<leader>an", function()
			vim.cmd("Augment chat")
		end, { desc = "Agumentcode chat new" })
	end,
}
