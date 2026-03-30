local utils = require('jc.plugins.utils')

vim.pack.add({
  utils.gh('lewis6991/gitsigns.nvim')
})

local gitsigns = require('gitsigns')

gitsigns.setup({
  word_diff = false
})


-- keymaps
vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { desc = "Show git diff" })
