local utils = require('jc.plugins.utils')

vim.pack.add({
  {
    src = utils.gh('nvim-mini/mini.indentscope'),
    version = 'stable'
  },
})

require('mini.indentscope').setup()
