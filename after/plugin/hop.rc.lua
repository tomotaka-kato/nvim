local status, hop = pcall(require, 'hop')
if not status then
    print('hop is not installed')
    return
end

hop.setup { keys = 'etovxqpdygfblzhckisuran' }
vim.api.nvim_set_keymap('', '<leader>w', "<cmd>lua require'hop'.hint_words()<cr>", { noremap = true })
