local keymap = vim.keymap

-- leaderはspaceバーにする
vim.g.mapleader = " "

local noramap = { noremap = true }

-- 0を^にする
keymap.set('n', '0', '^', noramap)

-- window移動
keymap.set('n', '<C-j>', '<C-w>j', noramap)
keymap.set('n', '<C-h>', '<C-w>h', noramap)
keymap.set('n', '<C-k>', '<C-w>k', noramap)
keymap.set('n', '<C-l>', '<C-w>l', noramap)

-- -- ターミナルのインサートモードから抜けるコマンドを変更
-- keymap.set('t', '<C-t>', '<C-\\><C-n>', noramap)
-- -- ターミナルの起動コマンド
-- keymap.set('n', '<C-t>s', '<cmd>botright new<CR><cmd>terminal<CR>', noramap)
-- keymap.set('n', '<C-t>v', '<cmd>rightbelow vnew<CR><cmd>terminal<CR>', noramap)
-- keymap.set('n', '<C-t>n', '<cmd>tabe<CR><cmd>terminal<CR>', noramap)
-- keymap.set('n', '<C-t>g', '<cmd>tabe<CR><cmd>terminal<CR>lazygit<CR>', noramap)

-- Telescope
keymap.set('n', '<C-p>', '<cmd>Telescope find_files<CR>', noramap)
keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', noramap)
keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', noramap)
keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>', noramap)

-- LuaSnip
-- インサートモードの時にTabで次の個所にジャンプする。nvimの記載方法でうまく書けなかった。。。
-- vim.cmd([[
--     imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
--     inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
-- ]])
