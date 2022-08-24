local status_telescope, telescope = pcall(require, 'telescope')

if not status_telescope then
    print('telescope is not installed.')
    return
end

vim.cmd [[nnoremap <C-p> <cmd>Telescope find_files<cr>]]
vim.cmd [[nnoremap <leader>fg <cmd>Telescope live_grep<cr>]]
vim.cmd [[nnoremap <leader>fb <cmd>Telescope buffers<cr>]]
vim.cmd [[nnoremap <leader>fd <cmd>Telescope diagnostics<cr>]]

-- file browser
local fb_actions = telescope.extensions.file_browser.actions
telescope.setup {
    extensions = {
        file_browser = {
            -- theme = "ivy",
            theme = "dropdown",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            initial_mode = 'normal',
            mappings = {
                ["i"] = {
                    ["<C-h>"] = fb_actions.goto_parent_dir
                },
                ["n"] = {
                    -- 他のマッピングと最初の部分が被ると処理が走るのが遅くなるので、CRを押す形にマッピングし直す
                    ["g"] = false,
                    ["h"] = fb_actions.goto_parent_dir,
                    ["H"] = fb_actions.toggle_hidden,
                    ["c"] = false,
                    ["c<cr>"] = fb_actions.create,
                    ["r"] = false,
                    ["r<cr>"] = fb_actions.rename,
                    ["m"] = false,
                    ["m<cr>"] = fb_actions.move,
                    ["y"] = false,
                    ["y<cr>"] = fb_actions.copy,
                    ["d"] = false,
                    ['d<cr>'] = fb_actions.remove
                },
            },
        },
    },
}
telescope.load_extension "file_browser"

vim.api.nvim_set_keymap(
    'n',
    '<C-e>',
    ':Telescope file_browser<CR>',
    { noremap = true }
)
