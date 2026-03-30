local utils = require("jc.plugins.utils")

vim.pack.add({
	{
		src = utils.gh("ThePrimeagen/harpoon"),
		version = "harpoon2",
	},
})

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():add()
end, { desc = "Add to harpoon" })
vim.keymap.set("n", "<leader>ho", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open harpoon Menu" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hp", function()
	harpoon:list():prev()
end, { desc = "Harpoon prev buffer" })
vim.keymap.set("n", "<leader>hn", function()
	harpoon:list():next()
end, { desc = "Harppon next buffer" })
vim.keymap.set("n", "<leader>1", function()
	harpoon:list():select(1)
end, { desc = "Select of harpoon list the append number 1" })
vim.keymap.set("n", "<leader>2", function()
	harpoon:list():select(2)
end, { desc = "Select of harpoon list the append number 2" })
vim.keymap.set("n", "<leader>3", function()
	harpoon:list():select(3)
end, { desc = "Select of harpoon list the append number 3" })
vim.keymap.set("n", "<leader>4", function()
	harpoon:list():select(4)
end, { desc = "Select of harpoon list the append number 4" })

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

vim.keymap.set("n", "<C-e>", function()
	toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })
