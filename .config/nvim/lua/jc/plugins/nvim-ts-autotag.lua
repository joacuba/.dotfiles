-- plugin for autoclose html jsx tags
return {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require('nvim-ts-autotag').setup({
            filetypes = { 'html', 'javascript', 'typescript', 'jsx', 'tsx', 'lua' },
        })
    end
}
