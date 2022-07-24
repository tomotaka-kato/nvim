vim.cmd[[packadd packer.nvim]]

require'packer'.startup(function(use)
    -- [begin] library
    use{'wbthomason/packer.nvim', opt = true}
    use('kyazdani42/nvim-web-devicons')
    use('onsails/lspkind-nvim') -- 補完にアイコンがつく
    -- [end] library
    -- LSP
    use('neovim/nvim-lspconfig')
    use("williamboman/nvim-lsp-installer")
    use("tamago324/nlsp-settings.nvim") -- プロジェクト固有のLSP設定をできるようにする
    use("tami5/lspsaga.nvim") -- LSPで表示するUIの変更
    use("folke/lsp-colors.nvim") -- LSPの色表示改善
    use("j-hui/fidget.nvim") -- LSPのプログレス表示
    -- [begin]補完
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    use("hrsh7th/cmp-nvim-lsp-document-symbol")
    use("SirVer/ultisnips") -- pip install neovim を実行する必要あり
    use("quangnguyen30192/cmp-nvim-ultisnips")
    use('honza/vim-snippets')
    -- [end]補完
    -- ファイラ
    use('lambdalisue/fern.vim')
    -- ファジーファインダ
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- treesitter
    use('nvim-treesitter/nvim-treesitter')
    use('p00f/nvim-ts-rainbow') -- カッコを色分け
    use('JoosepAlviste/nvim-ts-context-commentstring') -- gccでコメントアウト
    use('tpope/vim-commentary') -- 上記プラグインへコマンドだけ提供する
    -- カッコの補完
    use('cohama/lexima.vim')
    -- カラースキーム
    use('joshdick/onedark.vim')
    -- ステータスライン
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- ハイライト
    use('norcalli/nvim-colorizer.lua')
    -- 整形
    use('junegunn/vim-easy-align')
    -- テキストオブジェクト
    use('tpope/vim-surround')
    -- 移動
    use('yutkat/wb-only-current-line.vim') -- b, wが行を跨がない
end)

-- カラースキーム
vim.cmd[[colorscheme onedark]]

-- fern
vim.cmd[[let g:fern#default_hidden=1]]
-- Fern .をCtrl+eキーに置き換え
vim.cmd[[nnoremap <silent> <C-e>  :<C-u>Fern .<CR>]]

-- easy align
vim.cmd[[vmap <Enter> <Plug>(EasyAlign)]]
vim.cmd[[nmap ga <Plug>(EasyAlign)]]

require('settings.lsp')
require('settings.tree-sitter')
require('settings.telescope')
require('settings.statusline')

vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
