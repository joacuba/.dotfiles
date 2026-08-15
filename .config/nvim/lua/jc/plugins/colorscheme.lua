local utils = require("jc.plugins.utils")

vim.pack.add({
	{
		src = utils.gh("duarteocarmo/cursor-themes"),
		name = "cursor-theme",
	},
})

vim.cmd.colorscheme("cursor-dark")

-- background color
local function command_output(command)
	local handle = io.popen(command)
	if not handle then
		return ""
	end

	local result = handle:read("*a") or ""
	handle:close()
	return result
end

local function is_dark_mode()
	local system = vim.uv.os_uname().sysname

	if system == "Darwin" then
		return command_output("defaults read -g AppleInterfaceStyle 2>/dev/null"):match("Dark") ~= nil
	elseif system == "Linux" then
		-- GNOME 42+ (Ubuntu 22.04+) exposes the desktop preference directly.
		local color_scheme = command_output("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
		if color_scheme:match("prefer%-dark") then
			return true
		elseif color_scheme:match("prefer%-light") then
			return false
		end

		-- Fallback for older Ubuntu/GNOME versions.
		local gtk_theme = vim.env.GTK_THEME
			or command_output("gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null")
		return gtk_theme:lower():match("%-dark") ~= nil
	end

	return false
end

local current_background
local function update_background()
	local background = is_dark_mode() and "dark" or "light"
	if background == current_background then
		return
	end

	current_background = background
	vim.cmd.colorscheme("cursor-" .. background)
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
