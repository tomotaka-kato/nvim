"""""""""""""""""""""""""""""
"				dein setting				"
"""""""""""""""""""""""""""""
let s:use_dein = 1

" Prepare nvim dir
let s:vimdir = $HOME . "/.config/nvim"

" dein setting
let s:dein_enabled = 0
if s:use_dein
	let s:dein_enabled = 1

	" Set dein paths
	let s:dein_dir = s:vimdir . '/dein'
	let s:dein_github = s:dein_dir . '/repos/github.com'
	let s:dein_repo_name = "Shougo/dein.vim"
	let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

	" Check dein has been installed or not.
	if !isdirectory(s:dein_repo_dir)
		echo "dein is not installed, install now"
		let s:dein_repo = "https://github.com/" . s:dein_repo_name
		echo "git clone " . s:dein_repo . " " . s:dein_repo_dir
		call system("git clone " . s:dein_repo . " " . s:dein_repo_dir)
	endif
	let &runtimepath = &runtimepath . "," . s:dein_repo_dir

	" Begin plugin part
	call dein#begin(s:dein_dir)

	" TOML files
	let g:rc_dir = s:vimdir . "/rc"
	let s:toml = g:rc_dir . '/dein.toml'
	let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

	" Read TOML and cash
	call dein#load_toml(s:toml, {'lazy': 0})
	call dein#load_toml(s:lazy_toml, {'lazy': 1})

	" End setting
	call dein#end()
	call dein#save_state()
endif

" Install plugins if there are not installed plugins
if dein#check_install()
	call dein#install()
endif

"""""""""""""""""""""""""""
"				vim setting				"
"""""""""""""""""""""""""""

"バックアップ
set backup
set backupdir=$HOME/.config/nvim/tmp/backup

"アンドゥファイル
set undofile
set undodir=$HOME/.config/nvim/tmp/undo

"スワップファイル
set swapfile
set directory=$HOME/.config/nvim/tmp/swap

"エンコード
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp932,default,latin1

"表示
syntax on
set t_Co=256
set incsearch
set hlsearch
set laststatus=2
set background=dark
colorscheme hybrid
let g:seiya_auto_enable = 1 "ターミナル版の背景をターミナルと同じにする

" フォーマット
set formatoptions=q
set smarttab
set nowrap
set nrformats=
set noexpandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set expandtab
filetype plugin indent on " filetype プラグインによる indent を on にする
set formatoptions-=ro " 改行時にコメントアウトするのはなくす
let g:html_indent_inctags = "html,body,head,tbody" "HTMlのインデント

" マウス
set mouse=a

"その他
set backspace=indent,eol,start " インサートモード時にバックスペースを使う
set nrformats= "C-X,C-Aを強制的に10進数認識させる
set ruler
set confirm " 終了前に保存確認
set hidden " 保存前でも別ファイルを開ける
set autoread " 外部でファイルに変更がされた場合に読みなおす
set visualbell t_vb=
set helplang=ja,en
let loaded_matchparen = 1 " 括弧のハイライトをなくす
set ignorecase
set smartcase
set clipboard+=unnamed



" 行末のスーペースをハイライト
augroup HighlightTrailingSpaces
	autocmd!
	autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
	autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END


:source $VIMRUNTIME/macros/matchit.vim


augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
