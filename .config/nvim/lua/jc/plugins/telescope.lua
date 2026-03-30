local utils = require("jc.plugins.utils")

vim.pack.add({
	{
		src = utils.gh("nvim-telescope/telescope.nvim"),
		version = "master",
	},
	utils.gh("nvim-telescope/telescope-fzf-native.nvim"),
})

-- Configuration

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		path_display = { "smart" },
		mappings = {
			i = {
				["<C-p>"] = actions.move_selection_previous, -- move to the prev result
				["<C-n>"] = actions.move_selection_next, -- move to the prev result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- move to the prev result
			},
		},
		-- for layout docs see :help telescope.layout
		layout_strategy = "vertical",
		layout_config = { height = 0.95 },
	},
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")

-- keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find by Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find existing buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find current Word under the cursor" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
vim.keymap.set("n", "<leader>ft", function()
	vim.cmd("TodoTelescope")
end, { desc = "Find todos with telescope" })
vim.keymap.set("n", "<leader>fs", builtin.git_status, { desc = "Git: List current changes per file" })

-- hook for build fzf-native with cmake
local build_hook = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind

	if name == "telescope-fzf-native" and (kind == "install" or kind == "update") then
		-- ev.data.path for get the full pack of the plugin dir
		vim.fn.system({ "make", "-C", ev.data.path })
	end
end

-- Create autocmd trigger by vim.pack event PackChanged
vim.api.nvim_create_autocmd("PackChanged", { callback = build_hook })
