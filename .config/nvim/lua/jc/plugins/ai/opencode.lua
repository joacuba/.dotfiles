local utils = require("jc.plugins.utils")

vim.pack.add({
	utils.gh("nickjvandyke/opencode.nvim"),
	utils.gh("folke/snacks.nvim"),
})

-- Opencode configuration.
---@type opencode.Opts
vim.g.opencode_opts = {
	-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on the type or field.
}

-- Required for `opts.events.reload`.
vim.o.autoread = true

-- Recommended/example keymaps.
vim.keymap.set({ "n", "x" }, "<C-a>", function()
	require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode…" })
vim.keymap.set({ "n", "x" }, "<C-x>", function()
	require("opencode").select()
end, { desc = "Execute opencode action…" })
vim.keymap.set({ "n", "t" }, "<C-.>", function()
	require("opencode").toggle()
end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "go", function()
	return require("opencode").operator("@this ")
end, { desc = "Add range to opencode", expr = true })
vim.keymap.set("n", "goo", function()
	return require("opencode").operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })

vim.keymap.set("n", "<S-C-u>", function()
	require("opencode").command("session.half.page.up")
end, { desc = "Scroll opencode up" })
vim.keymap.set("n", "<S-C-d>", function()
	require("opencode").command("session.half.page.down")
end, { desc = "Scroll opencode down" })

-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o…".
--vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
--vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })

-- Snacks configuration.
require("snacks").setup({
	input = {
		enabled = true, -- Enable the input component.
	},
	picker = { -- Enhances `select()`
		enabled = true, -- Enable the picker component.
		actions = {
			opencode_send = function(...)
				return require("opencode").snacks_picker_send(...)
			end,
		},
		win = {
			input = {
				keys = {
					["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
				},
			},
		},
	},
	scroll = {
		enabled = true, -- Enable the scroll component.
	},
})
