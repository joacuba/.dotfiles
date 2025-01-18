return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate", -- the command will be execute when treesiter is install or update
	config = function()
		require("nvim-treesitter.configs").setup({
			-- enable sysntax highligghting
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = {
				enable = true,
			},
			-- enable autotag
			--autotag = {
			--    enable = true,
			--},
			-- ensure these language parser are installed
			ensure_installed = {
				"astro", -- Treesitter grammar for Astro web wramework
				"bash",
				"cmake",
				"cpp", -- c++ grammar for tree-sitter
				"rust",
				"css",
				"dockerfile",
				"gitignore",
				"go", -- go grammar
				"graphql",
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
				"yaml",
			},
		})
	end,
}
