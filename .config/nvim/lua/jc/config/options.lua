vim.g.netrw_liststyle = 3
local opt = vim.opt --short vim.opt

opt.relativenumber = true
opt.number = true
opt.cursorline = true

-- tabs & indentation
opt.tabstop = 2 --  spaces for tab (clangd style format), default value = 8
opt.shiftwidth = 2 -- number of spaces to use for each space of auto indent, defaul value = 8
opt.expandtab = true -- use the apropiated number of spaces to insert a <tab>
opt.autoindent = true -- copy the indent of the current line to the next one

opt.wrap = false -- avoid line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- one Upper case letter assume case-sensitive search

opt.termguicolors = true
opt.signcolumn = "yes" -- always show the sign column

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- use the system clipbard for default register

-- slipt windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- background color
local function update_background()
	local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")

	local result = handle:read("*a")
	handle:close()

	if result:match("Dark") then
		vim.opt.background = "dark"
	else
		vim.opt.background = "light"
	end
end

update_background()

local timer = vim.uv.new_timer()
timer:start(
	0, -- initial delay
	5000, -- check every 5 seconds
	vim.schedule_wrap(update_background)
)
