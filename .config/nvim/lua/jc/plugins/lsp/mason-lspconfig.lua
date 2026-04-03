local utils = require("jc.plugins.utils")

vim.pack.add({
	-- mason lsp installer
	utils.gh("mason-org/mason.nvim"),
	-- lsp configurations
	utils.gh("neovim/nvim-lspconfig"),
	-- mason-lsp-config bridges the gap between mason and lspconfig
	utils.gh("mason-org/mason-lspconfig.nvim"),
	-- mason tool installer, for installing non-lsp tools like formatters and linters
	utils.gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
})

-- mason configuration
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- mason lsp config configuration
require("mason-lspconfig").setup({
	ensure_installed = {
		"astro", -- astro framework
		"angularls", --angular lsp
		"vue_ls", --vue lsp
		"clangd", -- c++ server
		"copilot",
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

	--check :h mason-automatic-enable
	--
	--By default, `mason-lspconfig` will automatically enable servers you have
	--installed in Mason. This means you don't have to call |vim.lsp.enable()|
	--yourself.
})

-- mason tool installer configuration
require("mason-tool-installer").setup({
	ensure_installed = {
		-- formatters
		"prettier", -- prettier formatter
		"stylua", -- lua formater
		"isort", -- python formater
		"black", -- python formater
		-- 'gofmt' -- go formatter, already installed by go
		"clang-format", -- C/C++ formatter
		-- linters
		--"eslint-lsp", -- replace by eslint plugin
		"ruff", -- python rust base linter, before i was using pylint but i have venv problems
		"golangci-lint",
	},
})
