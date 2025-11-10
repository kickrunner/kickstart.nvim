-- Disable auto text wrapping when editing commit messages
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit', 'gitrebase', 'gitconfig', 'jj*' },
  callback = function()
    vim.opt_local.textwidth = 0
    --vim.opt_local.formatoptions:remove 't'
  end,
})
