local utils = require("jc.plugins.utils")

local build_hook = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind

	if name == "markdown-preview.nvim" and (kind == "install" or kind == "update") then
		vim.system({ "npx", "--yes", "yarn", "install" }, { cwd = ev.data.path .. "/app" }):wait()
	end
end

vim.api.nvim_create_autocmd("PackChanged", { callback = build_hook })

vim.pack.add({
	utils.gh("iamcco/markdown-preview.nvim"),
}, { load = false })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.cmd.packadd("markdown-preview.nvim")
	end,
})

vim.keymap.set("n", "<leader>mt", ":MarkdownPreviewToggle<CR>", { desc = "Toggle markdown preview" })
