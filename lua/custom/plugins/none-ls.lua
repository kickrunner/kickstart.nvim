vim.pack.add { 'https://github.com/nvimtools/none-ls.nvim' }
vim.pack.add { 'https://github.com/jay-babu/mason-null-ls.nvim' }

local nls = require 'null-ls'
nls.setup { sources = { nls.builtins.formatting.google_java_format, nls.builtins.formatting.prettier } }

require('mason-null-ls').setup {
  ensure_installed = {
    'google-java-format',
    'prettier',
  },
}
