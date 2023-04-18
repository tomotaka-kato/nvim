local status, packer = pcall(require, 'packer')
if (not status) then
    print("Packer is not installed.")
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
    -- [begin] library
    use { 'wbthomason/packer.nvim' }
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
    use('jose-elias-alvarez/null-ls.nvim') -- formatter, linter
    -- [end] LSP
    -- [begin]補完
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    use("hrsh7th/cmp-nvim-lsp-document-symbol")
    use('L3MON4D3/LuaSnip')
    use("saadparwaiz1/cmp_luasnip")
    use "rafamadriz/friendly-snippets"
    -- [end]補完
    -- ファジーファインダ
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use('nvim-telescope/telescope-file-browser.nvim')

    -- [begin] treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use("yioneko/nvim-yati") -- インデントをいい感じに
    use('p00f/nvim-ts-rainbow') -- カッコを色分け
    use('JoosepAlviste/nvim-ts-context-commentstring') -- gccでコメントアウト
    use('tpope/vim-commentary') -- 上記プラグインへコマンドだけ提供する
    use('m-demare/hlargs.nvim') -- 引数で渡された変数に色をつける
    use('nvim-treesitter/nvim-treesitter-textobjects') -- テキストオブジェクトを追加
    use('David-Kunz/treesitter-unit')
    -- [end] treesitter

    -- カッコの補完
    use { 'windwp/nvim-autopairs' }
    use { 'windwp/nvim-ts-autotag' }
    -- -- カラースキーム
    use ('joshdick/onedark.vim')
    use ('cocopon/iceberg.vim')
    use { 'xiyaowong/transparent.nvim' }
    -- ステータスライン
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- ハイライト
    use { 'norcalli/nvim-colorizer.lua' }
    use { "lukas-reineke/indent-blankline.nvim", } -- インデントのガイドを表示
    -- 整形
    use {
        'junegunn/vim-easy-align',
        vim.cmd [[xmap <C-Enter> <Plug>(EasyAlign)]],
        vim.cmd [[nmap <C-Enter> <Plug>(EasyAlign)]]
    }
    -- テキストオブジェクト
    use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
})
    -- 移動
    use('yutkat/wb-only-current-line.vim') -- b, wが行を跨がない
    use { -- easy motionのlua版みたいなもの
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
    }
    -- プレビュー
    use { 'turbio/bracey.vim', run = 'npm install --prefix server' }
    -- その他
    use { 'lewis6991/gitsigns.nvim' }
    use ('gpanders/editorconfig.nvim')
    use { 'petertriho/nvim-scrollbar'}
    use {"akinsho/toggleterm.nvim", tag = '*'}

    use { 'leafOfTree/vim-vue-plugin' }
    use {
        'heavenshell/vim-jsdoc',
        run = 'make install'
    }

    use { 'nvim-tree/nvim-tree.lua' }

    use { 'mzlogin/vim-markdown-toc' }

    -- :GitBlameToggle でgit blameの表示をトグルする
    use {
        'f-person/git-blame.nvim',
        vim.cmd [[
            let g:gitblame_enabled = 0
        ]]
    }

    use { 'tpope/vim-fugitive' }

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
}

end)

vim.cmd([[colorscheme onedark]])

require('scrollbar').setup()
require("transparent").setup()
