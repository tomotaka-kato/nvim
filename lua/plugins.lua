local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- [begin] library
    { 'nvim-lua/plenary.nvim', lazy = false },
    -- [begin] アイコン
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    { 'onsails/lspkind-nvim', lazy = true }, -- 補完にアイコンがつく
    -- [end] アイコン
    -- [begin] color scheme
    {
      'joshdick/onedark.vim',
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd([[colorscheme onedark]])
      end,
    },
    -- [end] color scheme
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
    { 'hrsh7th/cmp-nvim-lsp-signature-help', dependencies = { 'hrsh7th/nvim-cmp' } },
    { 'hrsh7th/cmp-nvim-lsp-document-symbol', dependencies = { 'hrsh7th/nvim-cmp' } },
    { 'L3MON4D3/LuaSnip', dependencies = { 'hrsh7th/nvim-cmp' } },
    { 'saadparwaiz1/cmp_luasnip', dependencies = { 'hrsh7th/nvim-cmp' } },
    { 'rafamadriz/friendly-snippets', dependencies = { 'hrsh7th/nvim-cmp' } } ,
    { "zbirenbaum/copilot.lua", lazy = true },
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
    {
      -- gccでコメントアウト
      'JoosepAlviste/nvim-ts-context-commentstring',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'numToStr/Comment.nvim' }
    },
    { 'numToStr/Comment.nvim', lazy = true }, -- 上記プラグインへコマンドだけ提供する
    { 'm-demare/hlargs.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter' } }, -- 引数で渡された変数に色をつける
    { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = { 'nvim-treesitter/nvim-treesitter' } }, -- テキストオブジェクトを追加
    { 'David-Kunz/treesitter-unit', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
    -- [end] treesitter
})

