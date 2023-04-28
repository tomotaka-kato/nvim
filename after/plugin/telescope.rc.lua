local status_telescope, telescope = pcall(require, 'telescope')

if not status_telescope then
    print('telescope is not installed.')
    return
end

require('telescope').load_extension('media_files')

telescope.setup({
    defaults = {
        layout_strategy = 'vertical',
        layout_config = {
            vertical = { width = 0.9 }
        },
    },
    extensions = {
        -- 動いてない。。。
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = {"png", "webp", "jpg", "jpeg"},
            -- find command (defaults to `fd`)
            find_cmd = "rg"
        }
    },
})

vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal wrap]]

