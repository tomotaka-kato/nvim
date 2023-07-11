local status, packer = pcall(require, 'packer')
if (not status) then
  print("Packer is not installed.")
  return
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
  use({
    "glepnir/lspsaga.nvim",
    -- opt = true,
    branch = "main",
    -- event = "LspAttach",
    -- config = function()
    --     require("lspsaga").setup({})
    -- end,
    requires = {
      {"nvim-tree/nvim-web-devicons"},
      --Please make sure you install markdown and markdown_inline parser
      {"nvim-treesitter/nvim-treesitter"}
    }
  })
  use("folke/lsp-colors.nvim") -- LSPの色表示改善
  use{ -- LSPのプログレス表示
    "j-hui/fidget.nvim",
    -- tag = "legacy", -- 破壊的変更が入るのでいったん固定。のはずがこいつ入れるとインストールに失敗する。。。
  }
  use('jose-elias-alvarez/null-ls.nvim') -- formatter, linter
  use('ray-x/lsp_signature.nvim')
  use({ -- エラーのある個所の下にvertual textでエラー内容を表示
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  })
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
  use { -- バインドなどの変更方法： https://rcmdnk.com/blog/2022/09/28/computer-vim/
    "github/copilot.vim",
    config = function()
      vim.cmd [[
        let g:copilot_no_tab_map = v:true
        imap <silent><script><expr> <C-e> copilot#Accept("\<CR>")
        let g:copilot_filetypes = {
              \ '*': v:true,
              \ 'xml': v:false,
              \ }
      ]]
    end
  }
  -- [end]補完
  -- ファジーファインダ
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  -- use('nvim-telescope/telescope-file-browser.nvim')

  -- [begin] treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use("yioneko/nvim-yati") -- インデントをいい感じに
  use('p00f/nvim-ts-rainbow') -- カッコを色分け
  use('JoosepAlviste/nvim-ts-context-commentstring') -- gccでコメントアウト
  use { -- 上記プラグインへコマンドだけ提供する
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use('m-demare/hlargs.nvim') -- 引数で渡された変数に色をつける
  use('nvim-treesitter/nvim-treesitter-textobjects') -- テキストオブジェクトを追加
  use 'David-Kunz/treesitter-unit'
  -- [end] treesitter

  -- カッコの補完
  use { 'windwp/nvim-autopairs' }
  use { 'windwp/nvim-ts-autotag' }
  -- カラースキーム
  use { 'joshdick/onedark.vim' }
  -- use ('cocopon/iceberg.vim')
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

  -- vueのシンタックスハイライト
  -- vue用のtreesitterはまだ安定してないので使わない
  use { 'leafOfTree/vim-vue-plugin' }
  use {
    'heavenshell/vim-jsdoc',
    run = 'make install'
  }

  use { 'nvim-tree/nvim-tree.lua' }

  use { 'mzlogin/vim-markdown-toc' }

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
      _, notify = pcall(require, 'notify')
      notify.setup({
        background_colour = "#000000"
      })
      vim.notify = notify
    end
  }

  use {"uga-rosa/ccc.nvim"} -- :CccPickでカラーピッカーが表示される

  -- カーソルの下の単語と同じ単語をハイライトする
  -- インストールしただけなので設定は確認する
  -- use { "RRethy/vim-illuminate" }

  use {'kevinhwang91/nvim-bqf', ft = 'qf'}

  -- 置換を便利に行えるやつ
  use { 'nvim-pack/nvim-spectre' }

  -- markdownをターミナル内でプレビューできる
  -- Glow [path-to-md-file] で起動できる
  -- q or Esc でぬけるが、ターミナルとして開いてるので一度ターミナルのインサートモードから抜けること
  use {"ellisonleao/glow.nvim", config = function() require("glow").setup() end}

  -- ページ移動を滑らかなスクロールにする
  -- ctrl-b や ctrl-f には効くが gg や Shift-g には効かない
  -- PCのスペックしょぼいとめっちゃ重い
  -- use { 
  --   'karb94/neoscroll.nvim',
  --   config = function ()
  --     require('neoscroll').setup({ })
  --     local t = {}
  --     -- Syntax: t[keys] = {function, {function arguments}}
  --     t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '10'}}
  --     t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '10'}}
  --     t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '10'}}
  --     t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '10'}}
  --     t['<C-y>'] = {'scroll', {'-0.10', 'false', '10'}}
  --     t['<C-e>'] = {'scroll', { '0.10', 'false', '10'}}
  --     t['zt']    = {'zt', {'10'}}
  --     t['zz']    = {'zz', {'10'}}
  --     t['zb']    = {'zb', {'10'}}
  --
  --     require('neoscroll.config').set_mappings(t)
  --   end
  -- }
end)

vim.cmd([[colorscheme onedark]])
