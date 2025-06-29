return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = {
			"astro", -- astro framework
			"clangd", -- c++ server
			"cmake", -- cmake
			"cssls", -- css server
			"cssmodules_ls", -- LSP for autocompletion and go to definition functionality for CSS modules
			"gopls", -- go server
			"graphql",
			"html", -- html server
			"ts_ls", -- javascript typescript server
			"lua_ls", -- lua server
			"prismals", -- prisma server
			"pyright", -- python server
			"tailwindcss", -- tailwind server
			"rust_analyzer", -- rust LSP
			"zls", -- zig lsp
		},
	},
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				ensure_installed = {
					-- formatters
					"prettier", -- prettier formatter
					"stylua", -- lua formater
					"isort", -- python formater
					"black", -- python formater
					-- 'gofmt' -- go formatter, already installed by go
					"clang-format", -- C/C++ formatter
					-- linters
					"eslint_d",
					"ruff", -- python rust base linter, before i was using pylint but i have venv problems
					"golangci-lint",
				},
			},
		},
		"neovim/nvim-lspconfig",
	},
}
