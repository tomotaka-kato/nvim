local status, toggleterm = pcall(require, 'toggleterm')

if not status then
    print('toggleterm.lua is note installed')
    return
end

toggleterm.setup()

-- vim.api.nvim_set_keymap(
--     'n',
--     'tt',
--     ':ToggleTerm<CR>',
--     { noremap = true }
-- )
