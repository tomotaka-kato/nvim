local status, packer = pcall(require, 'packer')
if (not status) then
    print("Packer is not installed.")
end

vim.cmd[[packadd packer.nvim]]

packer.startup(function(use)
    -- [begin] library
    use{'wbthomason/packer.nvim'}
    use('kyazdani42/nvim-web-devicons')
    use('onsails/lspkind-nvim') -- 補完にアイコンがつく
    -- [end] library
    -- [begin] LSP
    use('neovim/nvim-lspconfig')
    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')
    use("tamago324/nlsp-settings.nvim") -- プロジェクト固有のLSP設定をできるようにする
    use("tami5/lspsaga.nvim") -- LSPで表示するUIの変更
    use("folke/lsp-colors.nvim") -- LSPの色表示改善
    use("j-hui/fidget.nvim") -- LSPのプログレス表示
    use { 'jose-elias-alvarez/null-ls.nvim' } -- formatter, linter
    -- [end] LSP
    -- [begin]補完
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    use("hrsh7th/cmp-nvim-lsp-document-symbol")
    -- use("SirVer/ultisnips") -- pip install neovim を実行する必要あり
    use ('L3MON4D3/LuaSnip')
    use("saadparwaiz1/cmp_luasnip")
    use('honza/vim-snippets')
    -- [end]補完
    -- ファイラ
    use('lambdalisue/fern.vim')
    -- ファジーファインダ
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use('nvim-telescope/telescope-file-browser.nvim')
    -- [begin] treesitter
    use{ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use("yioneko/nvim-yati") -- インデントをいい感じに
    use('p00f/nvim-ts-rainbow') -- カッコを色分け
    use('JoosepAlviste/nvim-ts-context-commentstring') -- gccでコメントアウト
    use('tpope/vim-commentary') -- 上記プラグインへコマンドだけ提供する
    use ('m-demare/hlargs.nvim') -- 引数で渡された変数に色をつける
    use ('nvim-treesitter/nvim-treesitter-textobjects') -- テキストオブジェクトを追加
    use ('David-Kunz/treesitter-unit')
    -- [end] treesitter
    -- カッコの補完
    use {
        'windwp/nvim-autopairs',
        config = function () require("nvim-autopairs").setup {} end
    }
    use{
        'windwp/nvim-ts-autotag',
        require('nvim-ts-autotag').setup{}
    }
    -- カラースキーム
    use('joshdick/onedark.vim')
    -- ステータスライン
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- ハイライト
    use{
        'norcalli/nvim-colorizer.lua',
        require'colorizer'.setup()
    }
    -- 整形
    use('junegunn/vim-easy-align')
    -- テキストオブジェクト
    use('tpope/vim-surround')
    -- 移動
    use('yutkat/wb-only-current-line.vim') -- b, wが行を跨がない
    use { -- easy motionのlua版みたいなもの
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }
    -- プレビュー
    use{'turbio/bracey.vim', run = 'npm install --prefix server'}
end)

-- カラースキーム
vim.cmd[[colorscheme onedark]]

-- easy align
vim.cmd[[xmap ga <Plug>(EasyAlign)]]
vim.cmd[[nmap ga <Plug>(EasyAlign)]]

-- hop
-- vim.cmd[[nnoremap <silent><leader>w <cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>]]
-- vim.cmd[[nnoremap <silent><leader>w <cmd>lua require'hop'.hint_words()<cr>]]
vim.api.nvim_set_keymap('', '<leader>w', "<cmd>lua require'hop'.hint_words()<cr>", {noremap=true})

vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
