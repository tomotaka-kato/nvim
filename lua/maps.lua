local keymap = vim.keymap

-- leaderはspaceバーにする
vim.g.mapleader = " "

-- window移動
keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })

-- Increment/Decriment
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- ターミナルのインサートモードから抜けるコマンドを変更
keymap.set('t', '<C-t>', '<C-\\><C-n>', { noremap = true })
-- ターミナルの起動コマンド
keymap.set('n', '<C-t>s', '<cmd>botright new<CR><cmd>terminal<CR>', { noremap = true })
keymap.set('n', '<C-t>v', '<cmd>rightbelow vnew<CR><cmd>terminal<CR>', { noremap = true })
keymap.set('n', '<C-t>n', '<cmd>tabe<CR><cmd>terminal<CR>', { noremap = true })

