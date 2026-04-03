local M = {}

--[[For se more about lua coroutines and vim.system see:
-- https://www.lua.org/pil/9.1.html
-- https://neovim.io/doc/user/lua/#vim.system() or :h vim.system() in neovim
--]]

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
		vim.notify(msg, level or vim.log.levels.INFO, { title = "Git Commit AI" })
	end)
end

-- A helper function to run vim.system in a coroutine-friendly way
-- @param cmd The command to run as a list of strings, e.g. {"git", "status"}
-- @param opts The options to pass to vim.system, e.g. { cwd = "/path/to/repo", text = true }
local function sys(cmd, opts)
	-- Returns a function that, when called inside a coroutine,
	-- runs the command async, yields, and resumes with the result and then yields the result of the command when the system callback is called
	return function()
		local co = coroutine.running()
		vim.system(cmd, opts, function(systemCompletedObj)
			-- The system callback runs in a fast event context,
			-- so we schedule the resume back to the main loop.
			vim.schedule(function()
				coroutine.resume(co, systemCompletedObj)
			end)
		end)
		-- Suspend here. Resumes when the callback fires and yields the systemCompletedObj as the result of the sys() call.
		return coroutine.yield()
	end
end

-- Get the root of the git repository
local function get_repo_root()
	local systemCompletedObj = sys({
		"git",
		"rev-parse",
		"--show-toplevel",
	}, { text = true })()
	if systemCompletedObj.code ~= 0 then
		return nil, "Not inside a git repository"
	end
	return vim.trim(systemCompletedObj.stdout or "")
end

-- Get the staged files and their diff
-- @param cwd The current working directory (repository root)
local function get_staged_files(cwd)
	local systemCompletedObj = sys({
		"git",
		"diff",
		"--cached",
		"--",
		".",
	}, { cwd = cwd, text = true })()
	if systemCompletedObj.code ~= 0 then
		return nil, "Failed to get staged files"
	end
	return systemCompletedObj.stdout or ""
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
		"Do not include agent co-authors in the commit message.",
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

-- Run the agent CLI with the given prompt and return the generated commit message
local function run_agen_cli(cmd, cwd, prompt)
	local fullcmd = vim.list_extend(vim.deepcopy(cmd), { "--prompt", prompt })
	local systemCompletedObj = sys(fullcmd, { cwd = cwd, text = true })()
	if systemCompletedObj.code ~= 0 then
		return nil, "Failed to run" .. cmd[1] .. "agent cli: " .. (systemCompletedObj.stderr or "unknown error")
	end
	return systemCompletedObj.stdout or ""
end

-- Insert the generated commit message into the current buffer
-- @param bufnr The buffer number to insert the text into
-- @param text The commit message text to insert
local function insert_text_buffer(bufnr, text)
	vim.schedule(function()
		if not vim.api.nvim_buf_is_valid(bufnr) then
			notify("Buffer is no longer valid", vim.log.levels.ERROR)
			return
		end
		local lines = vim.split(text, "\n", { plain = true })
		vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, lines)
		vim.api.nvim_win_set_cursor(0, { 1, 0 })
	end)
end

-- The main function to generate a commit message and insert it into the current buffer
-- @param cmd The command to run the AI agent CLI (e.g., {"codex", "exec"})
function M.generate_commit_message(cmd)
	local bufnr = vim.api.nvim_get_current_buf()

	notify("Generating commit message...")

	coroutine.wrap(function()
		local repo_root, err = get_repo_root()
		if not repo_root then
			notify(err, vim.log.levels.ERROR)
			return
		end

		local staged_diff
		staged_diff, err = get_staged_files(repo_root)
		if not staged_diff then
			notify(err, vim.log.levels.ERROR)
			return
		end

		if staged_diff == "" then
			notify(
				"No staged changes found. Please stage some changes before generating a commit message.",
				vim.log.levels.WARN
			)
			return
		end

		local prompt = build_prompt(staged_diff)

		local commit_message
		commit_message, err = run_agen_cli(cmd, repo_root, prompt)
		if not commit_message then
			notify(err, vim.log.levels.ERROR)
			return
		end
		if commit_message == "" then
			notify("Agent did not return a commit message", vim.log.levels.WARN)
			return
		end
		insert_text_buffer(bufnr, commit_message)
		notify("Commit message generated successfully!")
	end)()
end

return M
