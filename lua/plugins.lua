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
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = "120"
    }
  },
  -- [end] util
  -- [begin] アイコン
  { 'nvim-tree/nvim-web-devicons', lazy = false },
  { 'onsails/lspkind-nvim', lazy = false }, -- 補完にアイコンがつく
  -- [end] アイコン
  -- [begin] 見た目
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd([[colorscheme everforest]])
    end,
  },
  {
    'joshdick/onedark.vim',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd([[colorscheme onedark]])
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        style = 'night',
        transparent = true,
        commentStyle = 'italic',
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          sidebars = 'dark', -- transparentよりも色がついてる方が見やすい
          floats = 'dark' -- transparentよりも色がついてる方が見やすい
        },
        sidebars = { 'qf', 'vista_kind', 'terminal', 'nvim-tree' },
      })
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  { 'xiyaowong/transparent.nvim', priority = 1000 },
  -- ステータスライン
  { 'nvim-lualine/lualine.nvim', priority = 1000 },
  -- ハイライト
  { 'norcalli/nvim-colorizer.lua', lazy = true }, -- cssなどのカラーコードに色を付ける
  { -- インデントのガイドを表示
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      require("ibl").setup { indent = { highlight = highlight } }
    end
  },
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
  { 'jose-elias-alvarez/null-ls.nvim', lazy = false }, -- formatter, linter
  {
    "folke/lsp-trouble.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
  },
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function ()
  --     require('lsp_lines').setup()
  --     vim.diagnostic.config({
  --       virtual_text = false
  --     })
  --     -- lsp_line
  --     vim.keymap.set(
  --       'n',
  --       '<leader>ll',
  --       require('lsp_lines').toggle,
  --       { noremap = true, desc = 'toggle lsp_lines' })
  --   end
  -- },
  -- [end] LSP
  -- [begin] 補完
  { 'hrsh7th/nvim-cmp', lazy = true, event = 'InsertEnter' },
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
  { "zbirenbaum/copilot.lua", lazy = true, event = 'InsertEnter' },
  { 'windwp/nvim-autopairs', event = "InsertEnter" },
  { 'windwp/nvim-ts-autotag', event = "InsertEnter" },
  -- [end] 補完
  -- [begin] ファジーファインダー
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- [end] ファジーファインダー
  -- [begin] treesitter
  { 'nvim-treesitter/nvim-treesitter', lazy = true, build = ':TSUpdate' },
  { "yioneko/nvim-yati", dependencies = { 'nvim-treesitter/nvim-treesitter' } }, -- インデントをいい感じに
  { 'numToStr/Comment.nvim', config = true }, -- 下記プラグインへコマンドだけ提供する
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
    config = true
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = { 'nvim-treesitter/nvim-treesitter' } }, -- テキストオブジェクトを追加
  { 'David-Kunz/treesitter-unit', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
  -- [end] text object
  -- [begin] move
  {'tomotaka-kato/wb-only-current-line.nvim', lazy = false}, -- b, w, eが行を跨がない
  { -- easy motionのlua版みたいなもの
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    lazy = true,
  },
  -- [end] move
  -- [begin] git
  { 'lewis6991/gitsigns.nvim', lazy = true },
  { 'tpope/vim-fugitive', lazy = true, event = 'CmdlineEnter' },
  -- [end] git
  -- [begin] language 
  { 'kevinhwang91/nvim-bqf', lazy = true, ft = 'qf' },
  -- vueのシンタックスハイライト
  -- vue用のtreesitterはまだ安定してないので使わない
  { 'leafOfTree/vim-vue-plugin', lazy = true, ft = 'vue' },
  {
    'heavenshell/vim-jsdoc',
    build = 'make install',
    lazy = true,
    ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'veu' }
  },
  { 'mzlogin/vim-markdown-toc', lazy = true, ft = 'markdown' },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    lazy = true,
    ft = "markdown",
  },
  {
    'rust-lang/rust.vim',
    lazy = true,
    ft = {'rust'},
    config = function ()
      vim.g.rustfmt_autosave = 1
    end
  }
  -- { -- markdownやneorgなどに対応したシンタックスハイライト
  --   -- neorgで使うと若干微妙かも。。。
  --   'lukas-reineke/headlines.nvim',
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = true, -- or `opts = {}`
  --   lazy = true,
  --   ft = { 'markdown', 'norg', 'org' }
  -- }
  -- [end] language
}

