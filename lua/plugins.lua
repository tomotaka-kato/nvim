return {
  -- [begin] library
  { 'nvim-lua/plenary.nvim', lazy = true },
  -- [end] library
  -- [begin] util
  { 'petertriho/nvim-scrollbar', lazy = false, config = true },
  { 'nvim-tree/nvim-tree.lua', lazy = true },
  {
    "folke/todo-comments.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    lazy = false,
    config = true
  },
  -- ファイルタイプで絞ってもいいかもしれない
  { 'editorconfig/editorconfig-vim', lazy = false },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {}
    end,
  },
  { 'anuvyklack/hydra.nvim', lazy = true },
  { "uga-rosa/ccc.nvim", lazy = true, cmd="CccPick" }, -- :CccPickでカラーピッカーが表示される
  -- 置換を便利に行えるやつ
  { 'nvim-pack/nvim-spectre', lazy = true },
  { 'https://codeberg.org/esensar/nvim-dev-container', lazy = true, },
  -- [end] util
  -- [begin] アイコン
  { 'nvim-tree/nvim-web-devicons', lazy = false },
  { 'onsails/lspkind-nvim', lazy = false }, -- 補完にアイコンがつく
  -- [end] アイコン
  -- [begin] 見た目
  {
    'joshdick/onedark.vim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme onedark]])
    end,
  },
  { 'xiyaowong/transparent.nvim', priority = 1000 },
  -- ステータスライン
  { 'nvim-lualine/lualine.nvim', priority = 1000 },
  -- ハイライト
  { 'norcalli/nvim-colorizer.lua', lazy = true }, -- cssなどのカラーコードに色を付ける
  { "lukas-reineke/indent-blankline.nvim", lazy = true }, -- インデントのガイドを表示
  {
    'rcarriga/nvim-notify',
    lazy = true,
    config = function()
      local _, notify = pcall(require, 'notify')
      notify.setup({
        background_colour = "#000000"
      })
      vim.notify = notify
    end
  },
  -- [end] 見た目
  -- [begin] LSP
  { 'neovim/nvim-lspconfig', lazy = true },
  { 'williamboman/mason.nvim', lazy = true },
  { 'williamboman/mason-lspconfig.nvim', lazy = true },
  { 'tamago324/nlsp-settings.nvim', lazy = true },-- プロジェクト固有のLSP設定をできるようにする
  {
    -- Breadcrumbsはこれが出してる
    "glepnir/lspsaga.nvim",
    branch = "main",
    lazy = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter"
    }
  },
  {
    -- LSPのプログレスUI
    'j-hui/fidget.nvim',
    tag = 'legacy',
  },
  { 'jose-elias-alvarez/null-ls.nvim', lazy = true }, -- formatter, linter
  {
    "folke/lsp-trouble.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
  },
  -- [end] LSP
  -- [begin] 補完
  { 'hrsh7th/nvim-cmp', lazy = true },
  { 'hrsh7th/cmp-nvim-lsp', dependencies = { 'hrsh7th/nvim-cmp' } },
  { 'hrsh7th/cmp-buffer', dependencies = { 'hrsh7th/nvim-cmp' } },
  {
    'hrsh7th/cmp-path',
    event = 'CmdlineEnter',
    dependencies = { 'hrsh7th/nvim-cmp' }
  },
  { 'hrsh7th/cmp-cmdline', dependencies = { 'hrsh7th/nvim-cmp' } },
  { 'hrsh7th/cmp-nvim-lsp-document-symbol', dependencies = { 'hrsh7th/nvim-cmp' } },
  { 'L3MON4D3/LuaSnip', dependencies = { 'hrsh7th/nvim-cmp' } },
  { 'saadparwaiz1/cmp_luasnip', dependencies = { 'hrsh7th/nvim-cmp' } },
  { 'rafamadriz/friendly-snippets', dependencies = { 'hrsh7th/nvim-cmp' } } ,
  { "zbirenbaum/copilot.lua", lazy = true },
  { 'windwp/nvim-autopairs', event = "InsertEnter" },
  { 'windwp/nvim-ts-autotag', event = "InsertEnter" },
  -- [end] 補完
  -- [begin] ファジーファインダー
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- [end] ファジーファインダー
  -- [begin] treesitter
  { 'nvim-treesitter/nvim-treesitter', lazy = true, build = ':TSUpdate' },
  { "yioneko/nvim-yati", dependencies = { 'nvim-treesitter/nvim-treesitter' } }, -- インデントをいい感じに
  { 'p00f/nvim-ts-rainbow', dependencies = { 'nvim-treesitter/nvim-treesitter' }  }, -- カッコを色分け
  { 'numToStr/Comment.nvim' }, -- 下記プラグインへコマンドだけ提供する
  {
    -- gccでコメントアウト
    'JoosepAlviste/nvim-ts-context-commentstring',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'numToStr/Comment.nvim' }
  },
  { 'm-demare/hlargs.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter' } }, -- 引数で渡された変数に色をつける
  -- [end] treesitter
  -- [begin] text object
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = { 'nvim-treesitter/nvim-treesitter' } }, -- テキストオブジェクトを追加
  { 'David-Kunz/treesitter-unit', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
  -- [end] text object
  -- [begin] move
  {'yutkat/wb-only-current-line.vim', lazy = true}, -- b, wが行を跨がない
  { -- easy motionのlua版みたいなもの
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    lazy = true,
  },
  -- [end] move
  -- [begin] git
  { 'lewis6991/gitsigns.nvim', lazy = true },
  { 'tpope/vim-fugitive', lazy = true },
  -- [end] git
  -- [begin] language 
  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  -- vueのシンタックスハイライト
  -- vue用のtreesitterはまだ安定してないので使わない
  { 'leafOfTree/vim-vue-plugin', ft = 'vue' },
  {
    'heavenshell/vim-jsdoc',
    build = 'make install',
    ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'veu' }
  },
  { 'mzlogin/vim-markdown-toc', ft = 'markdown' },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = "markdown",
  },
  {
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers',
    config = function ()
      require('neorg').setup {
        -- Tell Neorg what modules to load
        load = {
          ["core.defaults"] = {}, -- Load all the default modules
          ["core.integrations.treesitter"] = {},
          ["core.concealer"] = {
            config = {
              dim_code_blocks = {
                width = 'content'
              }
            }
          }, -- Allows for use of icons
          ["core.completion"] = {
            config = {
              engine = 'nvim-cmp',
              name = '[Neorg]'
            }
          },
          ["core.export"] = {},
          -- ["core.norg.dirman"] = { -- Manage your directories with Neorg
          --   config = {
          --     workspaces = {
          --       my_workspace = "~/neorg"
          --     }
          --   }
          -- }
        },
      }
    end
  }
  -- [end] language
}

