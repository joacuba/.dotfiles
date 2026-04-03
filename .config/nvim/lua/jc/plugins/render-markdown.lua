local utils = require("jc.plugins.utils")

vim.pack.add({
	utils.gh("MeanderingProgrammer/render-markdown.nvim"),
	-- the plugin needs the following dependencies
	-- nvim-web-devicons that is already installed in dependencies.lua
	-- and treesitter that is already installed in treesitter.lua
})

require("render-markdown").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
	-- https://github.com/MeanderingProgrammer/render-markdown.nvim?tab=readme-ov-file#setup
	file_types = { "markdown", "codecompanion" }, -- this plugin is used for codecompanion
})
