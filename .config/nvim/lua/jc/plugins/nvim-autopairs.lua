local utils = require("jc.plugins.utils")

vim.pack.add({
  utils.gh('windwp/nvim-autopairs')
})

require('nvim-autopairs').setup({
  check_ts = true,
})

-- If you want insert `(` after select function or method item
-- Automatically add parentheses '()' after selecting a function or method from the completion menu.
-- This integrates 'nvim-autopairs' with 'nvim-cmp' to handle function signatures upon confirmation.
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
