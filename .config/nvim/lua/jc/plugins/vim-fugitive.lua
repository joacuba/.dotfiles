local utils = require("jc.plugins.utils")

vim.pack.add({
  utils.gh('tpope/vim-fugitive')
})

-- keymaps
vim.keymap.set("n", "<leader>gs", function()
  vim.cmd("Git status")
end, { desc = "See git status" })

vim.keymap.set("n", "<leader>gp", function()
  vim.cmd("Git push")
end, { desc = "git push" })

vim.keymap.set("n", "<leader>gc", function()
  vim.cmd("Git commit")
end, { desc = "git commit" })

vim.keymap.set("n", "<leader>gd", function()
  vim.cmd("Git diff")
end, { desc = "git diff" })

vim.keymap.set("n", "<leader>og", function()
  vim.cmd("Git")
end, { desc = "Open fugitive (git)" })

vim.keymap.set("n", "<leader>glo", function()
  vim.cmd("Git log")
end, { desc = "git log" })

vim.keymap.set("n", "<leader>glg", function()
  vim.cmd("Git log --all --decorate --graph --oneline")
end, { desc = "git log graph" })
