local utils = require("jc.plugins.utils")

vim.pack.add({
  utils.gh('hrsh7th/nvim-cmp'),
  utils.gh('hrsh7th/cmp-nvim-lsp'),
  utils.gh('hrsh7th/cmp-buffer'),
  utils.gh('hrsh7th/cmp-path'),
  utils.gh('hrsh7th/cmp-cmdline'),

  -- Lua Snip
  {
    src = utils.gh('L3MON4D3/LuaSnip'),
    version = vim.version.range('2')
  },
  utils.gh('saadparwaiz1/cmp_luasnip'),
  utils.gh('onsails/lspkind.nvim'), -- vscode-like pictograms to neovim built-in lsp
})

local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

-- initialize luasnip
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({

  completion = {
    completeopt = "menu,menuone,preview,noselect",
    -- menu: Shows the popup menu with completion options
    -- menuone: Atumatically selects the entry in the popup menu
    -- preview: Preview te selected completion in a popup window
    -- noselect: Does not automatially select an item form the munu, you must choose on explicitly
  },
  snippet = { -- configure how nvim-cmp interacts with snippet engine cmp-luasnip
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({ -- deffinig keymaps for the cmp menu
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  -- sources for autocompletion
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- lsp source
    { name = "luasnip" }, -- snippets
    { name = "buffer" }, -- text within current buffer
    { name = "path" }, -- file system paths
  }),

  -- configure lspkind for vs-code like pictograms in completion menu
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- setup cmp nvim capabilities for all servers, see :help lsp-config-merge
vim.lsp.config("*", {
  capabilities = capabilities,
})


-- Lua-snip installation hook

local hook = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind

  if name == 'LuaSnip' and kind == 'install' then
    -- -C is the flag for change directory
    vim.fn.system({ 'make', '-C', ev.data.path, 'install_jsregexp' })
  end
end

-- Create autocmd trigger by vim.pack event PackChanged
vim.api.nvim_create_autocmd('PackChanged', { callback = hook })
