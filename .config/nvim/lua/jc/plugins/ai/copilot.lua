local utils = require("jc.plugins.utils")

vim.pack.add({
	utils.gh("zbirenbaum/copilot.lua"),
})

require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		keymap = {
			accept = false,
		},
	},
	filetypes = {
		sh = function()
			if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
				-- disable for .env files
				return false
			end
			return true
		end,
	},
	should_attach = function(_, bufname)
		if string.match(bufname, "CodeCompanion") then
			return true
		end
		return true
	end,
})

vim.keymap.set("i", "<Tab>", function()
	if require("copilot.suggestion").is_visible() then
		require("copilot.suggestion").accept()
		return ""
	end
	return vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
end, { expr = true, silent = true })
