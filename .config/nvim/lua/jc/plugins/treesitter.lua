local utils = require("jc.plugins.utils")

-- check the plugin requirements:
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#requirements

vim.pack.add({
	{
		src = utils.gh("nvim-treesitter/nvim-treesitter"),
		version = "main",
	},
})

-- Installing languages parsers
local treesitter = require("nvim-treesitter")
treesitter
	.install({
		"angular",
		"astro", -- Treesitter grammar for Astro web wramework
		"bash",
		"cmake",
		"cpp", -- c++ grammar for tree-sitter
		"rust",
		"regex",
		"css",
		"dockerfile",
		"gitignore",
		"go", -- go grammar
		"graphql",
		"gitignore", --git ignore
		"query", -- query file treesitter
		"html",
		"json",
		"java",
		"javascript",
		"lua",
		"markdown",
		"markdown_inline",
		"prisma",
		"python",
		"tmux", -- tmux treesitter
		"toml", -- for alacrity toml file
		"tsx", -- for tsx and jsx
		"typescript",
		"vim", -- use vim with vimdoc
		"vimdoc", -- use vimdoc with vim
		"vue",
		"yaml",
		"zig", -- zig parser Tresitter
		"zsh",
	})
	:wait(300000) -- 5 min wait until the parser are installed

-- hook for run :TSUpdate when the plugins state has change (In this case update)
-- this automatization is recommended by treesitter docs
-- you can check more about hooks runing :h vim.pack-events

local hook = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind

	if name == "nvim-treesitter" and kind == "update" then
		vim.cmd(":TSUpdate")
	end
end

-- Create autocmd trigger by vim.pack event PackChanged
vim.api.nvim_create_autocmd("PackChanged", { callback = hook })
