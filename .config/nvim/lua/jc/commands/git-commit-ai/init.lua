local git_commit_ai = require("jc.commands.git-commit-ai.core")

local cmd = {
	"copilot",
	"--model",
	"gpt-5-mini",
	"--deny-tool",
	"read",
	"--deny-tool",
	"shell",
	"--deny-tool",
	"write",
}

vim.api.nvim_create_user_command("GitCommitAI", function()
	git_commit_ai.generate_commit_message(cmd)
end, { desc = "Generate a git commit message using AI based on the staged changes" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function(args)
		vim.keymap.set(
			"n",
			"<leader>ai",
			"<cmd>GitCommitAI<CR>",
			{ buffer = args.buf, desc = "Generate commit message using AI" }
		)
	end,
})
