local status_telescope, telescope = pcall(require, 'telescope')

if not status_telescope then
    print('telescope is not installed.')
    return
end

vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal wrap]]

-- vim.cmd [[nnoremap <C-p> <cmd>Telescope find_files<cr>]]
-- vim.cmd [[nnoremap <leader>fg <cmd>Telescope live_grep<cr>]]
-- vim.cmd [[nnoremap <leader>fb <cmd>Telescope buffers<cr>]]
-- vim.cmd [[nnoremap <leader>fd <cmd>Telescope diagnostics<cr>]]

vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<CR>', { noremap = true })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true })
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>', { noremap = true })

