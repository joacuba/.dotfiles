local utils = require("jc.plugins.utils")

vim.pack.add({
	utils.gh("sphamba/smear-cursor.nvim"),
})

require("smear_cursor").setup({
	enabled = true, -- Enable the plugin
	stiffness = 0.5,
	trailing_stiffness = 0.5,
	matrix_pixel_threshold = 0.5,
})
