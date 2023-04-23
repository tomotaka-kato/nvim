local status_telescope, telescope = pcall(require, 'telescope')

if not status_telescope then
    print('telescope is not installed.')
    return
end

telescope.setup({
    defaults = {
        layout_strategy = 'vertical',
        layout_config = {
            vertical = { width = 0.9 }
        },
    }
})

vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal wrap]]

vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<CR>', { noremap = true })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true })
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>', { noremap = true })

