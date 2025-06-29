return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
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
		})

		mason_tool_installer.setup({
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
		})
	end,
}
