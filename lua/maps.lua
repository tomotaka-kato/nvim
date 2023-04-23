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

-- ターミナルのインサートモードから抜けるコマンドをESCに変更
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
