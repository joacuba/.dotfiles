require "jc.plugins.lsp.mason-lspconfig"
require "jc.plugins.lsp.eslint"

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")

    map("gr", require("telescope.builtin").lsp_references, "Goto References")

    map("gI", require("telescope.builtin").lsp_implementations, "Goto Impelemetantion")

    map("<leader>D", require("telescope.builtin").diagnostics, "Goto Impelemetantion")

    map("gD", vim.lsp.buf.declaration, "Goto Declaration")

    map("<leader>rn", vim.lsp.buf.rename, "ReName")

    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")

    map("K", vim.lsp.buf.hover, "Hover Documentation")

    map("<leader>rs", ":LspRestart<CR>", "Restart LSP")
  end,
})

-- the capabilities of the lsp are inside the folder jc.plugins.nvim-cmp L:66
