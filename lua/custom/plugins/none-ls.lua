return {
  {
    'nvimtools/none-ls.nvim',
    config = function()
      local nls = require 'null-ls'
      nls.setup { sources = { nls.builtins.formatting.google_java_format } }
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
    opt = {
      ensure_installed = {
        'google-java-format',
      },
    },
  },
}
