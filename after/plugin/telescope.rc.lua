local status_telescope, telescope = pcall(require, 'telescope')

if not status_telescope then
    print('telescope is not installed.')
    return
end

vim.cmd [[nnoremap <C-p> <cmd>Telescope find_files<cr>]]
vim.cmd [[nnoremap <leader>fg <cmd>Telescope live_grep<cr>]]
vim.cmd [[nnoremap <leader>fb <cmd>Telescope buffers<cr>]]
vim.cmd [[nnoremap <leader>fd <cmd>Telescope diagnostics<cr>]]

