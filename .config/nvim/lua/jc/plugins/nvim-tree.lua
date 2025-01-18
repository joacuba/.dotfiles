-- nvim-tree is a file explorer tree writing in lua
return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require "nvim-tree".setup({
            view = {
                width = 35,
                number = true,
                relativenumber = true,
            },
            -- disable window_picker for explorer to work well with window splits
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    }
                },
                expand_all = {
                    max_folder_discovery = 300,
                    exclude = {
                        "Desktop",
                        "Downloads",
                        "Movies",
                        "Pictures",
                        "Documents",
                        "Library",
                        "Music",
                        "Public",
                    }
                }

            },
            filters = {
                custom = {
                    ".DS_Store"
                },
            },
            
            -- show files ignore by git
            
            git = {
                ignore = false,
            },
        })

        vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
        vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on the current buffer" })
        vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapses the nvim-tree recursively" })
        vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh the tree" })
    end
}
