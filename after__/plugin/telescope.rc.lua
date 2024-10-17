local status_telescope, telescope = pcall(require, 'telescope')

if not status_telescope then
    print('telescope is not installed.')
    return
end

-- require('telescope').load_extension('media_files')

telescope.setup({
    defaults = {
        layout_strategy = 'vertical',
        layout_config = {
            vertical = { width = 0.9 }
        },
    },
    extensions = { },
})

vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal wrap]]

