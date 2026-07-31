local utils = require("jc.plugins.utils")

vim.pack.add({
	{
		src = utils.gh("duarteocarmo/cursor-themes"),
		name = "cursor-theme",
	},
})

vim.cmd.colorscheme("cursor-dark")

-- background color
local function update_background()
	local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")

	local result = handle:read("*a")
	handle:close()

	if result:match("Dark") then
		--vim.opt.background = "dark"
		vim.cmd.colorscheme("cursor-dark")
	else
		--vim.opt.background = "light"
		vim.cmd.colorscheme("cursor-light")
	end
end

update_background()

local timer = vim.uv.new_timer()
timer:start(
	0, -- initial delay
	5000, -- check every 5 seconds
	vim.schedule_wrap(update_background)
)

--vim.pack.add({
--	{
--		src = utils.gh("rose-pine/neovim"),
--		name = "rose-pine",
--	},
--})
--
--require("rose-pine").setup({
--	dark_variant = "moon",
--	palette = {
--		moon = {
--			base = "#1A1A1A",
--			surface = "#1A1A1A",
--		},
--		dawn = {
--			base = "#FFFFFF",
--			surface = "#FFFFFF",
--		},
--	},
--})
--
--vim.cmd("colorscheme rose-pine")
--
