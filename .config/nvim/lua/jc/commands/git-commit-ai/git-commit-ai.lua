-- Fist iteration fo the code
local M = {}

-- Notify helper
-- @param msg The message to display
-- @param level The log level (optional, defaults to INFO)
local function notify(msg, level)
	-- Use Neovim's built-in notification system to display messages
	-- [[The last argument is a table of options, this is not use by
	-- neovim but can be used by plugins that hook into the notification system]]
	-- Here we use vim.schedule to ensure that the notification is displayed in the correct context, especially if this function is called from a callback of vim.system
	-- this is becuase vim.system callbacks may not be called in the main event loop, and using vim.schedule ensures that the notification is displayed properly without causing issues with the event loop
	-- Without vim.schedule, if this function is called from a vim.system callback, it may cause issues with the event loop and the notification may not be displayed properly
	-- callbacks from vim.system() execute in a libuv event loop context, and Neovim restricts API calls like nvim_ech in this case vim.notify
	vim.schedule(function()
		vim.notify(msg, level or vim.log.levels.INFO, { title = "Git commit gen" })
	end)
end

-- Get the root of the git repository
-- @param scheduleCallback via vim.shedule A callback function that will be called with the repository root as an argument
local function get_repo_root(callback)
	vim.system({
		"git",
		"rev-parse",
		"--show-toplevel",
	}, { text = true }, function(systemCompletedObj)
		if systemCompletedObj.code ~= 0 then
			notify("Not inside a git repository", vim.log.levels.ERROR)
			return
		end
		local root = vim.trim(systemCompletedObj.stdout or "")
		vim.schedule(function()
			callback(root)
		end)
	end)
end

-- Get the staged files and their diff
-- @param cwd The current working directory (repository root)
-- @param callback A callback function that will be called with the diff of the staged files as an argument
local function get_staged_files(cwd, callback)
	vim.system({
		"git",
		"diff",
		"--cached",
		"--",
		".",
	}, { cwd = cwd, text = true }, function(systemCompletedObj)
		if systemCompletedObj.code ~= 0 then
			notify("Failed to get staged files", vim.log.levels.ERROR)
			return
		end
		callback(systemCompletedObj.stdout or "")
	end)
end

-- Build the prompt for the AI model based on the staged diff
-- @param diff The diff of the staged files
local function build_prompt(diff)
	return table.concat({
		"You are generating a git commit message.",
		"",
		"Return ONLY the commit message text.",
		"Do not use markdown fences.",
		"Use Conventional Commits format.",
		"Write a rich body explaining what changed and why.",
		"Keep the subject line under 72 characters if possible.",
		"",
		"Format:",
		"<type>(optional-scope): <subject>",
		"",
		"<body>",
		"",
		"Use the staged diff below:",
		"",
		diff,
	}, "\n")
end

-- Run the AI agent CLI with the given prompt and handle the response
-- @param cmd The command to run the AI agent CLI (e.g., {"git-commit-ai"})
-- @param cwd The current working directory (repository root)
-- @param prompt The prompt to send to the AI agent CLI
-- @param callback A callback function that will be called with the generated commit message as an argument
local function run_agent_cli(cmd, cwd, propmt, callback)
	local fullcmd = vim.list_extend(vim.deepcopy(cmd), { "--prompt", propmt })
	vim.system(fullcmd, { text = true, cwd = cwd }, function(systemCompletedObj)
		if systemCompletedObj.code ~= 0 then
			notify(
				(cmd[1] .. " cli agent failed with code " .. (systemCompletedObj.code or "unknown error")),
				vim.log.levels.ERROR
			)
			return
		end
		callback(vim.trim(systemCompletedObj.stdout or ""))
	end)
end

-- Replace the text in the current buffer with the generated commit message
-- @param bufnr The buffer number of the current buffer
-- @param text The generated commit message to replace the buffer text with
local function replace_buffer_text(bufnr, text)
	vim.schedule(function()
		if vim.api.nvim_buf_is_valid(bufnr) then
			local lines = vim.split(text, "\n", { plain = true })
			vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, lines)
			vim.api.nvim_win_set_cursor(0, { 1, 0 })
		end
	end)
end

-- Main function to generate the commit message
-- @param cmd The command to run the AI agent CLI (e.g., {"claude"})
function M.generate_commit_message(cmd)
	local bufnr = vim.api.nvim_get_current_buf()
	--if vim.bo[bufnr].filetype ~= "gitcommit" then
	--	notify("This command can only be used in a gitcommit buffer", vim.log.levels.ERROR)
	--	return
	--end
	notify("Generating commit message from staged diff...")

	get_repo_root(function(repo_root)
		get_staged_files(repo_root, function(diff)
			if diff == "" then
				notify("No staged changes found", vim.log.levels.WARN)
				return
			end
			local prompt = build_prompt(diff)
			run_agent_cli(cmd, repo_root, prompt, function(commit_message)
				if commit_message == "" then
					notify("Agent did not return a commit message", vim.log.levels.WARN)
					return
				end
				replace_buffer_text(bufnr, commit_message)
				notify("Commit message generated successfully!")
			end)
		end)
	end)
end

return M
