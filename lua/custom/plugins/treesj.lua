vim.pack.add { 'https://github.com/wansmer/treesj' }

local tsj = require 'treesj'

tsj.setup {
  use_default_keymaps = false,
}

vim.keymap.set('n', '<leader>rt', require('treesj').toggle, { desc = 'T[r]eeSJ: [T]oggle node under cursor' })
vim.keymap.set(
  'n',
  '<leader>rT',
  function() require('treesj').toggle { split = { recursive = true } } end,
  { desc = 'T[r]eeSJ: [T]oggle node, split recursive' }
)
