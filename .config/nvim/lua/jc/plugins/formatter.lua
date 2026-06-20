local utils = require("jc.plugins.utils")

vim.pack.add({
	utils.gh("stevearc/conform.nvim"),
})

local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "oxfmt", "prettier" },
		typescript = { "oxfmt", "prettier" },
		javascriptreact = { "oxfmt", "prettier" },
		typescriptreact = { "oxfmt", "prettier" },
		astro = { "prettier" },
		css = { "oxfmt", "prettier" },
		html = { "oxfmt", "prettier" },
		json = { "oxfmt", "prettier" },
		vue = { "oxfmt" },
		yaml = { "oxfmt", "prettier" },
		toml = { "oxfmt" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		lua = { "stylua" },
		python = { "isort", "black" },
		cpp = { "clang-format" },
		go = { "gofmt" },
		rust = { "rustfmt", lsp_format = "fallback" }, -- rust formater installed automatically when installed rustup tools. And also setting LSP as fallback for formating
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	},
})

vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end, { desc = "Format file or range (in visual mode)" })
