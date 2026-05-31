vim.pack.add { 'https://github.com/christoomey/vim-tmux-navigator' }

vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Tmux Navigate Left' })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Tmux Navigate Down' })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Tmux Navigate Up' })
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Tmux Navigate Right' })
vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<cr>', { desc = 'Tmux Navigate Previous' })
