return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")

				map("gr", require("telescope.builtin").lsp_references, "Goto References")

				map("gI", require("telescope.builtin").lsp_implementations, "Goto Impelemetantion")

				map("<leader>D", require("telescope.builtin").diagnostics, "Goto Impelemetantion")

				map("gD", vim.lsp.buf.declaration, "Goto Declaration")

				map("<leader>rn", vim.lsp.buf.rename, "ReName")

				map("<leader>ca", vim.lsp.buf.code_action, "Code Action")

				map("K", vim.lsp.buf.hover, "Hover Documentation")
			end,
		})
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- setup cmp nvim capabilities for all servers, see :help lspconfig-new
		vim.lsp.config("*", {
			capabilities = capabilities,
		})
	end,
}
