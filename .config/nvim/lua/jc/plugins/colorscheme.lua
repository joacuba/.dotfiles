return {
	"metalelf0/black-metal-theme-neovim",
	lazy = false,
	priority = 1000,
	config = function()
		require("black-metal").setup({
			-- optional configuration here
		})
		require("black-metal").load()
	end,
}
--return {
--	"bluz71/vim-moonfly-colors",
--	name = "moonfly",
--	lazy = false,
--	priority = 1000,
--	config = function()
--		vim.cmd([[colorscheme moonfly]])
--	end,
--}

--return {
--	"webhooked/kanso.nvim",
--	lazy = false,
--	priority = 1000,
--	opts = {
--		theme = "zen",
--		transparent = true,
--		terminalColors = true,
--	},
--	init = function()
--		vim.cmd("colorscheme kanso")
--	end,
--}

--return {
--	"rose-pine/neovim",
--	name = "rose-pine",
--	config = function()
--		require("rose-pine").setup({
--			styles = {
--				transparency = true,
--			},
--		})
--		vim.cmd("colorscheme rose-pine")
--	end,
--}
