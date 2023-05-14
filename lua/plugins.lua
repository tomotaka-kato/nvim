local status, packer = pcall(require, 'packer')
if (not status) then
    print("Packer is not installed.")
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
    -- [begin] library
    use { 'wbthomason/packer.nvim' }
    use { 'nvim-tree/nvim-web-devicons' }
    use('onsails/lspkind-nvim') -- 補完にアイコンがつく
    -- [end] library
    -- [begin] LSP
    use('neovim/nvim-lspconfig')
    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')
    use("tamago324/nlsp-settings.nvim") -- プロジェクト固有のLSP設定をできるようにする
    use("kkharji/lspsaga.nvim") -- LSPで表示するUIの変更
    use("folke/lsp-colors.nvim") -- LSPの色表示改善
    use("j-hui/fidget.nvim") -- LSPのプログレス表示
    use('jose-elias-alvarez/null-ls.nvim') -- formatter, linter
    use('ray-x/lsp_signature.nvim')
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
    use ('nvim-telescope/telescope-media-files.nvim')

    -- [begin] treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use("yioneko/nvim-yati") -- インデントをいい感じに
    use('p00f/nvim-ts-rainbow') -- カッコを色分け
    use('JoosepAlviste/nvim-ts-context-commentstring') -- gccでコメントアウト
    use('tpope/vim-commentary') -- 上記プラグインへコマンドだけ提供する
    use('m-demare/hlargs.nvim') -- 引数で渡された変数に色をつける
    use('nvim-treesitter/nvim-treesitter-textobjects') -- テキストオブジェクトを追加
    use('David-Kunz/treesitter-unit')
    -- 画面に収まらない関数名を表示する
    -- デフォルトの設定だとちょっと見にくいので使わないかも。。。
    -- use{
    --     'nvim-treesitter/nvim-treesitter-context' ,
    --     config = function()
    --         require'treesitter-context'.setup{
    --             enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    --             max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    --             min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    --             line_numbers = true,
    --             multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
    --             trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    --             mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    --             -- Separator between context and content. Should be a single character string, like '-'.
    --             -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    --             separator = nil,
    --             zindex = 20, -- The Z-index of the context window
    --         }
    --     end
    -- }
    -- [end] treesitter

    -- カッコの補完
    use { 'windwp/nvim-autopairs' }
    use { 'windwp/nvim-ts-autotag' }
    -- -- カラースキーム
    use { 'joshdick/onedark.vim' }
    use ('cocopon/iceberg.vim')
    use { 'xiyaowong/transparent.nvim',
        config = function()
            require("transparent").setup()
        end
    }
    -- ステータスライン
    use { 'nvim-lualine/lualine.nvim' }
    -- ハイライト
    use { 'norcalli/nvim-colorizer.lua' } -- cssなどのカラーコードに色を付ける
    use { "lukas-reineke/indent-blankline.nvim", } -- インデントのガイドを表示
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
    use { 'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar').setup()
        end
    }

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

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })

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

    use { 'editorconfig/editorconfig-vim' }

    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    use {
        "folke/lsp-trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    use { 'anuvyklack/hydra.nvim'  }

    use{
        'rcarriga/nvim-notify',
        config = function()
            vim.notify = require("notify").setup({
                background_colour = "#000000"
            })
        end
    }

    use {
        "nvim-neorg/neorg",
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.concealer"] = {}, -- Adds pretty icons to your documents
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            -- workspaces = {
                            --     notes = "~/notes",
                            -- },
                        },
                    },
                },
            }
        end,
        run = ":Neorg sync-parsers",
        requires = "nvim-lua/plenary.nvim",
    }

end)

vim.cmd([[colorscheme onedark]])
