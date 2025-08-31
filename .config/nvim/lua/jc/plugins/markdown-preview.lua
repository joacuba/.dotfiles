-- Preview Markdown in your modern browser with synchronised scrolling and flexible configuration
return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	config = function()
		vim.keymap.set("n", "<leader>mr", function()
			vim.cmd("MarkdownPreviewToggle")
		end, { desc = "Markdown Preview Toggle" })
	end,
	build = "cd app && npm install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
}
