vim.pack.add { 'https://github.com/gbprod/yanky.nvim' }

require('yanky').setup {
  ring = {
    storage = 'shada',
  },
}

require('telescope').load_extension 'yank_history'
vim.keymap.set('n', '<leader>sy', require('telescope').extensions.yank_history.yank_history, { desc = '[S]earch [Y]ank History' })

vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

vim.keymap.set('n', '<c-p>', '<Plug>(YankyPreviousEntry)')
vim.keymap.set('n', '<c-n>', '<Plug>(YankyNextEntry)')
