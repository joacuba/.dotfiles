local utils = require("jc.plugins.utils")

vim.pack.add({ utils.gh('stevearc/oil.nvim') })

require("oil").setup({
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true
  }
})

-- Keymap to open oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory Oil.nvim" })
