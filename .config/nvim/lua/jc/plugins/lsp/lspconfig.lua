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

				map("<leader>rs", ":LspRestart<CR>", "Restart LSP")
			end,
		})
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local mason_registry = require("mason-registry")

		-- setup cmp nvim capabilities for all servers, see :help lspconfig-new
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		--local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
		--	.. "/node_modules/@vue/language-server"
		local vue_language_server_path = vim.fn.stdpath("data")
			.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

		--- ts_ls server configuration
		-- This setup add the fily type vue and the vue plugin to typescript language server
		-- Reference 1: https://github.com/StevanFreeborn/nvim-config/blob/63bf20565b67d3a6c31839edf1ad2453ecd3bf84/lua/plugins/lsp.lua#L64-L80
		-- Reference 2: https://github.com/vuejs/language-tools/wiki/Neovim
		vim.lsp.config.ts_ls = {
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = vue_language_server_path,
						languages = { "vue" },
					},
				},
			},
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
				"vue",
			},
		}
	end,
}
