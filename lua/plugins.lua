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
    -- [begin]補完
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    use("hrsh7th/cmp-nvim-lsp-document-symbol")
    use("f3fora/cmp-spell")
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
    -- カッコの補完
    use('cohama/lexima.vim')
    -- カラースキーム
    use('joshdick/onedark.vim')
    -- 整形
    use('junegunn/vim-easy-align')
    -- テキストオブジェクト
    use('tpope/vim-surround')
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

vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
