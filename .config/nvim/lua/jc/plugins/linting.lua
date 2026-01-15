return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint" }, -- replace eslint_d with eslint because works with eslint-lsp that mason provides
			typescript = { "eslint" },
			javascriptreact = { "eslint" },
			typescriptreact = { "eslint" },
			astro = { "eslint" },
			python = { "ruff" },
			cpp = { "clangtidy" }, -- not available in Mason, install llvm for use clang-tidy
			h = { "clangtidy" }, -- not available in Mason, install llvm for use clang-tidy
			go = { "golangcilint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
			print("linting now")
		end, { desc = "Trigger linting for current file" })
	end,
}
