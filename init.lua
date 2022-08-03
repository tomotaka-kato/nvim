vim.g.mapleader = " "
-- プラグイン設定
require 'plugins'

-- マウス有効化
vim.o.mouse = 'a'
vim.o.title = true

-- backup, undo, swap
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = false -- 容量を食うので一旦なしにする。欲しくなったら再検討
vim.cmd [[set undodir=$HOME/.config/nvim/tmp/undo]]
vim.o.swapfile = false

-- エンコード vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

-- 表示
vim.o.number = true
vim.o.hlsearch = true
vim.o.laststatus = 2
vim.o.termguicolors = true
vim.cmd [[let loaded_matchparen = 1]] --" 括弧のハイライトをなくす
vim.o.termguicolors = true

-- 改行コード、半角スペース、タブの可視化
vim.o.list = true
vim.o.listchars = 'tab:»-,trail:-,eol:¬'

-- クリップボードを共有する
vim.o.clipboard = "unnamedplus"

-- フォーマット
vim.o.smarttab = true
vim.o.wrap = false
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes"
vim.o.ignorecase = true
vim.o.smartcase = true
-- vim.o.cursorline = true
vim.o.virtualedit = 'block' ---空白文字まで矩形選択できるようにする

-- コメント行で改行をしてもコメントが続かないようにする
vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- 終了時に保存確認
vim.o.confirm = true

-- マッピング
-- window移動
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })

-- プラグインのセットアップ後じゃないとエラーになる。
-- なのでこちらで宣言
require 'colorizer'.setup()
