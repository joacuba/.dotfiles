vim.cmd("let g:netrw_liststyle = 3")

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
opt.background = "dark"
opt.signcolumn = "yes" -- always show the sign column

-- backspace
opt.backspace = "indent,eol,start"

-- clipbaord
opt.clipboard:append("unnamedplus") -- use the system clipbard for default register

-- slipt windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- moonflyTransparent options for moonfly Theme for neovim
vim.g.moonflyTransparent = true
