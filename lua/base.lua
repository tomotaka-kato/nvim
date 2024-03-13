-- マウス有効化
vim.o.mouse = 'a'
vim.o.title = true

-- backup, undo, swap
vim.o.backup = false
vim.o.writebackup = false
-- vim.o.undofile = false -- 容量を食うので一旦なしにする。欲しくなったら再検討
vim.o.undofile = true
vim.cmd [[set undodir=$HOME/.config/nvim/tmp/undo]]
vim.o.swapfile = false

-- エンコード
vim.scriptencodeing = 'utf-8'
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.fileformat = 'unix'

-- 表示
vim.o.number = true
vim.o.hlsearch = true
vim.o.laststatus = 2
vim.o.termguicolors = true
-- vim.cmd [[let loaded_matchparen = 1]] -- 括弧のハイライトをなくす
vim.cmd [[set nofoldenable]] -- foldによる折りたたみをなくす
-- vim.opt.winblend = 20 --フロートウィンドウなどを若干透明に
vim.o.winblend = 0 --フロートウィンドウなどを若干透明に
vim.o.scrolloff = 5

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
-- vim.cmd([[
-- augroup highlight_current_line
--   autocmd!
--   autocmd WinEnter * setlocal cursorline
--   autocmd WinLeave * setlocal nocursorline
--   " autocmd CursorMoved * if &cursorline | setlocal nocursorline | endif
--   " autocmd CursorMovedI * if &cursorline | setlocal nocursorline | endif
--   autocmd InsertEnter * setlocal nocursorline
--   autocmd InsertLeave * setlocal cursorline
--   autocmd VimEnter * setlocal cursorline
--   autocmd VimLeave * setlocal nocursorline
--   autocmd BufEnter * highlight CursorLine cterm=underline gui=underline guibg=none ctermbg=none
--   autocmd BufLeave * highlight CursorLine cterm=none gui=none
--   " autocmd WinEnter,BufWinEnter * highlight CursorLine cterm=underline gui=underline guibg=#101010 ctermbg=233
--   " autocmd WinLeave,BufWinLeave * highlight CursorLine cterm=none gui=none
--   autocmd WinEnter * highlight CursorLine cterm=underline gui=underline guibg=none ctermbg=none
--   autocmd WinLeave * highlight CursorLine cterm=none gui=none
-- augroup END
-- ]])

vim.diagnostic.config({
  -- virtual_text = false,
})

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

-- powershellでの起動が遅いため適当に突っ込んでる。
-- nvim全体の軌道を早めるためにもうちょい見直したい。
vim.cmd([[
" Disable default plugins {{{
" Fast Startup Settings!!
" Disable TOhtml.
let g:loaded_2html_plugin       = v:true

" Disable archive file open and browse.
let g:loaded_gzip               = v:true
let g:loaded_tar                = v:true
let g:loaded_tarPlugin          = v:true
let g:loaded_zip                = v:true
let g:loaded_zipPlugin          = v:true

" Disable vimball.
let g:loaded_vimball            = v:true
let g:loaded_vimballPlugin      = v:true

" Disable netrw plugins.
let g:loaded_netrw              = v:true
let g:loaded_netrwPlugin        = v:true
let g:loaded_netrwSettings      = v:true
let g:loaded_netrwFileHandlers  = v:true

" Disable `GetLatestVimScript`.
let g:loaded_getscript          = v:true
let g:loaded_getscriptPlugin    = v:true

" Disable other plugins
let g:loaded_man                = v:true
let g:loaded_matchit            = v:true
let g:loaded_matchparen         = v:true
let g:loaded_shada_plugin       = v:true
let g:loaded_spellfile_plugin   = v:true
let g:loaded_tutor_mode_plugin  = v:true
let g:did_install_default_menus = v:true
let g:did_install_syntax_menu   = v:true
let g:skip_loading_mswin        = v:true
let g:did_indent_on             = v:true
let g:did_load_ftplugin         = v:true
let g:loaded_rrhelper           = v:true

" }}}

]])
