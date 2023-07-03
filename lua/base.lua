-- マウス有効化
vim.o.mouse = 'a'
vim.o.title = true

-- backup, undo, swap
vim.o.backup = false
vim.o.writebackup = false
-- vim.o.undofile = false -- 容量を食うので一旦なしにする。欲しくなったら再検討
vim.o.undofile = true -- 容量を食うので一旦なしにする。欲しくなったら再検討
vim.cmd [[set undodir=$HOME/.config/nvim/tmp/undo]]
vim.o.swapfile = false

-- エンコード
vim.scriptencodeing = 'utf-8'
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

-- 表示
vim.o.number = true
vim.o.hlsearch = true
vim.o.laststatus = 2
vim.cmd [[let loaded_matchparen = 1]] -- 括弧のハイライトをなくす
vim.o.termguicolors = true

-- 改行コード、半角スペース、タブの可視化
vim.o.list = true
vim.o.listchars = 'tab:»-,trail:-,eol:¬'

-- クリップボードを共有する
-- vim.o.clipboard = "unnamedplus"

-- フォーマット
vim.o.smarttab = true
vim.o.wrap = false
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.signcolumn = "yes"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.virtualedit = 'block' ---空白文字まで矩形選択できるようにする

-- コメント行で改行をしてもコメントが続かないようにする
vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

vim.cmd [[
    if system('uname -a } grep microsoft') != ''
        augroup myYank
            autocmd!
            autocmd TextyankPost * :call system('clip.exe', @")
        augroup END
    endif"
]]

-- 終了時に保存確認
vim.o.confirm = true

-- 現在行の表示をアンダーラインにする
vim.cmd([[
augroup highlight_current_line
  autocmd!
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  " autocmd CursorMoved * if &cursorline | setlocal nocursorline | endif
  " autocmd CursorMovedI * if &cursorline | setlocal nocursorline | endif
  autocmd InsertEnter * setlocal nocursorline
  autocmd InsertLeave * setlocal cursorline
  autocmd VimEnter * setlocal cursorline
  autocmd VimLeave * setlocal nocursorline
  autocmd BufEnter * highlight CursorLine cterm=underline gui=underline guibg=none ctermbg=none
  autocmd BufLeave * highlight CursorLine cterm=none gui=none
  " autocmd WinEnter,BufWinEnter * highlight CursorLine cterm=underline gui=underline guibg=#101010 ctermbg=233
  " autocmd WinLeave,BufWinLeave * highlight CursorLine cterm=none gui=none
  autocmd WinEnter * highlight CursorLine cterm=underline gui=underline guibg=none ctermbg=none
  autocmd WinLeave * highlight CursorLine cterm=none gui=none
augroup END
]])

vim.diagnostic.config({
  -- virtual_text = false,
})

-- :Tでnvim標準のターミナルを現在のウィンドウの下に開く
vim.cmd([[command! -nargs=* T split | wincmd j | resize 20 | terminal <args>]])
-- ターミナルを開いたら自動でインサートモードになるようにする
vim.cmd([[autocmd TermOpen * startinsert]])

-- ubuntu環境ではnodeのバージョンが古いのでバイナリの場所を指定する
-- 古いnodeだとvolarが動かないため
local f = io.popen("whoami")
if f == nil then
    return
end
local user = f:read("*l")
---@diagnostic disable-next-line: missing-parameter
f.close()
if user:find('ubuntu') then
vim.cmd([[
    let $PATH='/home/ubuntu/.nvm/versions/node/v16.19.1/bin:' . $PATH
]])
end



