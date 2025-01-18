vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "No Highlight" })

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split the window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split the window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Split window equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Split window Close" })

-- tabs
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Tab open" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Tab close" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Tab next" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "tab prev" })
vim.keymap.set("n", "<leader>tb", "<cmd>tabnew %<CR>", { desc = "Open current buffer in a new tab" })
