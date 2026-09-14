vim.diagnostic.config {
  underline = true,
  virtual_text = false,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
  },
}

vim.pack.add { 'https://github.com/rachartier/tiny-inline-diagnostic.nvim' }

local diag = require('tiny-inline-diagnostic')

diag.setup {
  preset = 'powerline',
  transparent_cursorline = false,
  options = {
    multilines = {
      enabled = true,
    },
  },
}

vim.keymap.set('n', '<leader>td', function()
  diag.toggle()
end, { desc = '[T]oggle Inline [D]iagnostics' })
