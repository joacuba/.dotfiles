local git_commit_ai = require("jc.commands.git-commit-ai.core")

local cmd = {
	"opencode",
	"--model",
	"opencode/big-pickle",
	"--pure", --pure cmd is for run opencode without plugins
}

local prompt_cmd = "run"

vim.api.nvim_create_user_command("GitCommitAI", function()
	git_commit_ai.generate_commit_message(prompt_cmd, cmd)
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
