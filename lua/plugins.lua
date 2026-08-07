return {
    --------------------------------
    -- External package Installer
    {
        "mason-org/mason.nvim",
        lazy = false,
        opts = {},
    },
    -- [end] library
    --------------------------------

    --------------------------------
    -- Notify
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            require("rc/pluginconfig/nvim-notify")
        end,
    }, -- Notify
    --------------------------------

    --------------------------------

    -- ColorScheme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("rc/pluginconfig/tokyonight")
        end,
    },
    --------------------------------

    --------------------------------
    -- Font
    {
        "kyazdani42/nvim-web-devicons",
        enabled = function()
            return not os.getenv("DISABLE_DEVICONS") or os.getenv("DISABLE_DEVICONS") == "false"
        end,
    },
    {
        "delphinus/cellwidths.nvim",
        event = "VeryLazy",
        config = function()
            require("cellwidths").setup({
                name = "default",
            })
        end,
    },
    --------------------------------

    --------------------------------------------------------------
    -- LSP & completion
    --------------------------------
    -- Auto Completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
            require("rc/pluginconfig/nvim-cmp")
        end,
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lsp-document-symbol" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-emoji" },
            { "hrsh7th/cmp-calc" },
            { "f3fora/cmp-spell" },
            { "yutkat/cmp-mocword" },
            { "saadparwaiz1/cmp_luasnip" },
            {
                "tzachar/cmp-tabnine",
                build = "./install.sh",
            },
            { "ray-x/cmp-treesitter" },
            { "lukas-reineke/cmp-rg" },
            { "lukas-reineke/cmp-under-comparator" },
            {
                "onsails/lspkind-nvim",
                config = function()
                    require("rc/pluginconfig/lspkind-nvim")
                end,
            },
        },
    },

    -- Auto Completion
    --------------------------------
    -- Language Server Protocol(LSP)
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("rc/pluginconfig/nvim-lspconfig")
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- LSPは必要になったタイミングで :LspInstall から追加する
            ensure_installed = {},
            automatic_enable = true,
        },
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },
    -- [end] Language Server Protocol(LSP)
    --------------------------------
    --------------------------------------------------------------

    ----------------------------------
    ---- Snippet
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        build = "make install_jsregexp",
        config = function()
            require("rc/pluginconfig/LuaSnip")
        end,
    },
    --------------------------------

    --------------------------------------------------------------
    -- FuzzyFinders

    --------------------------------
    -- telescope.nvim
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        cmd = "Telescope",
        keys = {
            { "<C-p>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
            { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
            { "<leader>rf<CR>", "<cmd>Telescope lsp_refactors<CR>", desc = "LSP refactors" },
        },
        config = function()
            ---@diagnostic disable-next-line: different-requires
            require("rc/pluginconfig/telescope")
            require("telescope").load_extension("frecency")
            require("telescope").load_extension("heading")
            require("telescope").load_extension("luasnip")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-frecency.nvim",
            "crispgm/telescope-heading.nvim",
            "benfowler/telescope-luasnip.nvim",
            -- TODO: 依存関係のせいでsqliteエラーが出るのでコメントアウトしてる。どれが悪さしてるのかとか調査する
            -- {
            --     "nvim-telescope/telescope-github.nvim",
            --     config = function()
            --         require("telescope").load_extension("gh")
            --     end,
            -- },
            -- {
            --     "nvim-telescope/telescope-ui-select.nvim",
            --     config = function()
            --         require("telescope").load_extension("ui-select")
            --     end,
            -- },
            -- {
            --     "LinArcX/telescope-changes.nvim",
            --     config = function()
            --         require("telescope").load_extension("changes")
            --     end,
            -- },
            -- {
            --     "nvim-telescope/telescope-live-grep-args.nvim",
            --     config = function()
            --         require("telescope").load_extension("live_grep_args")
            --     end,
            -- },
            -- {
            --     "nvim-telescope/telescope-smart-history.nvim",
            --     config = function()
            --         require("telescope").load_extension("smart_history")
            --     end,
            --     build = function()
            --         os.execute("mkdir -p " .. vim.fn.stdpath("state") .. "databases/")
            --     end,
            -- },
            -- { "nvim-telescope/telescope-symbols.nvim" },
            -- {
            --     "debugloop/telescope-undo.nvim",
            --     config = function()
            --         require("telescope").load_extension("undo")
            --     end,
            -- },
        },
    },
    -- [end] telescope.nvim
    -- -----------	--------------------------------

    ---------------------
    -- LSP's UI
    {
        "nvimdev/lspsaga.nvim",
        event = "VeryLazy",
        config = function()
            require("rc/pluginconfig/lspsaga")
        end,
    },
    -- [end] LSP's UI
    ---------------------

    ---------------------
    -- Treesitter

    -- [end] Treesitter
    ---------------------



    --------------------------------
    -- [begin] util
    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        config = function()
            require('scrollbar').setup()
        end,
    },
    {
      "nvim-tree/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
      keys = {
        { "<C-e>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
      },
      dependencies = {
        "b0o/nvim-tree-preview.lua",
        {
          "antosha417/nvim-lsp-file-operations",
          dependencies = { "nvim-lua/plenary.nvim" },
          config = function()
            require("lsp-file-operations").setup()
          end,
        },
      },
      config = function()
          require("rc/pluginconfig/nvim-tree")
      end,
    },
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      event = { "BufReadPost", "BufNewFile" },
      config = true,
    },
    {
    	"folke/which-key.nvim",
    	config = function()
    		vim.o.timeout = true
    		vim.o.timeoutlen = 300
    		require("which-key").setup({})
    	end,
    },
    {
      "anuvyklack/hydra.nvim",
      keys = { "<C-w>" },
      config = function()
        require("rc/pluginconfig/hydra")
      end,
    },
    -- { "uga-rosa/ccc.nvim", lazy = true, cmd = "CccPick", config = true }, -- :CccPickでカラーピッカーが表示される
    -- -- 置換を便利に行えるやつ
    -- { "nvim-pack/nvim-spectre", lazy = true },
    -- { "https://codeberg.org/esensar/nvim-dev-container", lazy = true },
    -- {
    -- 	"m4xshen/smartcolumn.nvim",
    -- 	opts = {
    -- 		colorcolumn = "120",
    -- 	},
    -- },
    -- {
    -- 	"monaqa/dial.nvim",
    -- 	lazy = false,
    -- 	config = function()
    -- 		-- この設定は公式からコピペしただけ
    -- 		-- TODO: 別ファイルへ移動 and 自分に合った設定に変更
    -- 		local augend = require("dial.augend")
    -- 		require("dial.config").augends:register_group({
    -- 			default = {
    -- 				augend.integer.alias.decimal,
    -- 				augend.integer.alias.hex,
    -- 				augend.date.alias["%Y/%m/%d"],
    -- 			},
    -- 			typescript = {
    -- 				augend.integer.alias.decimal,
    -- 				augend.integer.alias.hex,
    -- 				augend.constant.new({ elements = { "let", "const" } }),
    -- 			},
    -- 			visual = {
    -- 				augend.integer.alias.decimal,
    -- 				augend.integer.alias.hex,
    -- 				augend.date.alias["%Y/%m/%d"],
    -- 				augend.constant.alias.alpha,
    -- 				augend.constant.alias.Alpha,
    -- 			},
    -- 		})
    --
    -- 		vim.keymap.set("n", "<C-a>", function()
    -- 			require("dial.map").manipulate("increment", "normal")
    -- 		end)
    -- 		vim.keymap.set("n", "<C-x>", function()
    -- 			require("dial.map").manipulate("decrement", "normal")
    -- 		end)
    -- 		vim.keymap.set("n", "g<C-a>", function()
    -- 			require("dial.map").manipulate("increment", "gnormal")
    -- 		end)
    -- 		vim.keymap.set("n", "g<C-x>", function()
    -- 			require("dial.map").manipulate("decrement", "gnormal")
    -- 		end)
    -- 		vim.keymap.set("v", "<C-a>", function()
    -- 			require("dial.map").manipulate("increment", "visual")
    -- 		end)
    -- 		vim.keymap.set("v", "<C-x>", function()
    -- 			require("dial.map").manipulate("decrement", "visual")
    -- 		end)
    -- 		vim.keymap.set("v", "g<C-a>", function()
    -- 			require("dial.map").manipulate("increment", "gvisual")
    -- 		end)
    -- 		vim.keymap.set("v", "g<C-x>", function()
    -- 			require("dial.map").manipulate("decrement", "gvisual")
    -- 		end)
    -- 	end,
    -- },
    -- { "thinca/vim-partedit", lazy = false },
    -- -- [end] util
    -- --------------------------------
    --
    -- -- [begin] 見た目
    -- { "xiyaowong/transparent.nvim", priority = 1000 },
    -- -- ステータスライン
    {
      "nvim-lualine/lualine.nvim",
      config = function()
          require("rc/pluginconfig/lualine")
      end,
      priority = 1000
    },
    -- -- ハイライト
    -- { "norcalli/nvim-colorizer.lua", lazy = true }, -- cssなどのカラーコードに色を付ける
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

            local hooks = require("ibl.hooks")
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

            require("ibl").setup({ indent = { highlight = highlight } })
        end,
    },
    -- -- [end] 見た目
    -- -- [begin] LSP
    -- { "neovim/nvim-lspconfig", lazy = true },
    -- { "tamago324/nlsp-settings.nvim", lazy = true }, -- プロジェクト固有のLSP設定をできるようにする
    -- {
    -- 	-- Breadcrumbsはこれが出してる
    -- 	"glepnir/lspsaga.nvim",
    -- 	branch = "main",
    -- 	lazy = true,
    -- 	dependencies = {
    -- 		"nvim-treesitter/nvim-treesitter",
    -- 	},
    -- },
    {
    	-- LSPのプログレスUI
    	"j-hui/fidget.nvim",
    	tag = "legacy",
    },
    -- {
    -- 	"nvimtools/none-ls.nvim",
    -- 	dependencies = {
    -- 		"nvimtools/none-ls-extras.nvim",
    -- 	},
    -- 	lazy = false,
    -- }, -- formatter, linter
    -- {
    -- 	"folke/lsp-trouble.nvim",
    -- 	dependencies = { "nvim-tree/nvim-web-devicons" },
    -- },
    -- -- {
    -- -- diagnosticを対象の位置の下に表示してくれる。
    -- -- ただ、これを使うとコード全体が上下に動いてしまって見づらいので使わない
    -- --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    -- --   config = function ()
    -- --     require('lsp_lines').setup()
    -- --     vim.diagnostic.config({
    -- --       virtual_text = false
    -- --     })
    -- --     -- lsp_line
    -- --     vim.keymap.set(
    -- --       'n',
    -- --       '<leader>ll',
    -- --       require('lsp_lines').toggle,
    -- --       { noremap = true, desc = 'toggle lsp_lines' })
    -- --   end
    -- -- },
    -- -- lazy.nvim
    -- -- {
    -- -- 右上にかっこよく通知が出るようになる。
    -- -- デフォルトだとちょっと使いにくいので設定をしっかりするまでオフにする。
    -- -- 設定しても使いにくい場合はアンインストールする。
    -- -- 	"folke/noice.nvim",
    -- -- 	event = "VeryLazy",
    -- -- 	dependencies = {
    -- -- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    -- -- 		"MunifTanjim/nui.nvim",
    -- -- 		-- OPTIONAL:
    -- -- 		--   `nvim-notify` is only needed, if you want to use the notification view.
    -- -- 		--   If not available, we use `mini` as the fallback
    -- -- 		"rcarriga/nvim-notify",
    -- -- 	},
    -- -- },
    -- -- [end] LSP
    -- -- [begin] 補完
    {
    	"github/copilot.vim",
    	lazy = true,
    	event = "InsertEnter",
    	config = function()
    		vim.keymap.set("i", "<C-e>", 'copilot#Accept("\\<CR>")', {
    			expr = true,
    			replace_keycodes = false,
    		})
    		vim.keymap.set("i", "<C-Space>", "copilot#Trigger()", {
    			expr = true,
    			replace_keycodes = false,
    		})
    		vim.g.copilot_no_tab_map = true
    		vim.cmd([[
           let g:copilot_filetypes = {
             \ '*': v:true
           \}
         ]])
    	end,
    },
    { --NOTE: とりあえず使いたかったのでコメントを外した。時間がある時に設定の見直し
    	"CopilotC-Nvim/CopilotChat.nvim",
    	branch = "main",
    	build = "make tiktoken",
        cmd = {
          "CopilotChat",
          "CopilotChatPrompts",
          "CopilotChatModels",
          "CopilotChatOpen",
          "CopilotChatClose",
          "CopilotChatToggle",
          "CopilotChatStop",
          "CopilotChatReset",
          "CopilotChatSave",
          "CopilotChatLoad",
        },
        keys = {
          {
            "<C-c>",
            function()
              require("CopilotChat").open({ selection = require("CopilotChat.select").visual })
            end,
            mode = { "n", "x" },
            desc = "Open CopilotChat",
          },
          {
            "<leader><C-p>",
            "<cmd>CopilotChatPrompts<CR>",
            mode = { "n", "x" },
            desc = "CopilotChat prompts",
          },
        },
    	opt = {
    		debug = true,
    	},
    	dependencies = {
    		{ "github/copilot.vim" },
    		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
      config = function()
          require("rc/pluginconfig/copilotChat")
      end,
    	-- See Commands section for default commands if you want to lazy load on them
    },
    { "windwp/nvim-autopairs", lazy = true, event = "InsertEnter", config = true },
    { "windwp/nvim-ts-autotag", lazy = true, event = "InsertEnter", config = true },
    -- -- [end] 補完
    -- -- [begin] ファジーファインダー
    -- -- [end] ファジーファインダー
    -- [begin] treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "main",
      lazy = false,
      build = ":TSUpdate",
      config = function()
          require("rc/pluginconfig/tree-sitter")
      end,
    },
    -- { "numToStr/Comment.nvim", config = true }, -- 下記プラグインへコマンドだけ提供する
    -- {
    -- 	-- gccでコメントアウト
    -- 	"JoosepAlviste/nvim-ts-context-commentstring",
    -- 	dependencies = { "nvim-treesitter/nvim-treesitter", "numToStr/Comment.nvim" },
    -- 	config = function()
    -- 		vim.g.skip_ts_context_commentstring_module = true
    -- 	end,
    -- },
    -- { "m-demare/hlargs.nvim", dependencies = { "nvim-treesitter/nvim-treesitter" } }, -- 引数で渡された変数に色をつける
    -- -- [end] treesitter
    --
    -- -- [begin] text object
    -- {
    -- 	"kylechui/nvim-surround",
    -- 	version = "*", -- Use for stability; omit to use `main` branch for the latest features
    -- 	config = true,
    -- },
    -- { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } }, -- テキストオブジェクトを追加
    -- { "gcmt/wildfire.vim" },
    -- -- [end] text object
    --
    -- -- [begin] move
    { "tomotaka-kato/wb-only-current-line.nvim", lazy = false }, -- b, w, eが行を跨がない
    { -- easy motionのlua版みたいなもの
      "smoka7/hop.nvim", -- optional but strongly recommended
      keys = {
        { "<leader>w", "<cmd>HopWord<CR>", mode = { "n", "x", "o" }, desc = "Hop word" },
        { "<leader>l", "<cmd>HopLineStart<CR>", mode = { "n", "x", "o" }, desc = "Hop line" },
      },
      config = function()
          require("rc/pluginconfig/hop")
      end,
    },
    -- -- [end] move
    -- [begin] git
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("gitsigns").setup()
      end,
    },
    -- { "tpope/vim-fugitive", lazy = true, event = "CmdlineEnter" },
    -- [end] git
    -- -- [begin] language
    -- { "kevinhwang91/nvim-bqf", lazy = true, ft = "qf" },
    -- -- vueのシンタックスハイライト
    -- -- vue用のtreesitterはまだ安定してないので使わない
    -- { "leafOfTree/vim-vue-plugin", lazy = true, ft = "vue" },
    -- {
    -- 	"heavenshell/vim-jsdoc",
    -- 	build = "make install",
    -- 	lazy = true,
    -- 	ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "veu" },
    -- },
    -- { "mzlogin/vim-markdown-toc", lazy = true, ft = "markdown" },
    -- {
    -- 	"rust-lang/rust.vim",
    -- 	lazy = true,
    -- 	ft = { "rust" },
    -- 	config = function()
    -- 		vim.g.rustfmt_autosave = 1
    -- 	end,
    -- },
    -- {
    -- 	"akinsho/flutter-tools.nvim",
    -- 	requires = { "nvim-lua/plenary.nvim" },
    -- 	ft = { "dart" },
    -- 	config = true,
    -- },
    -- {
    -- 	"dart-lang/dart-vim-plugin",
    -- 	ft = { "dart" },
    -- 	config = function()
    -- 		vim.g.dart_format_on_save = 1
    -- 	end,
    -- },
    -- { -- markdownやneorgなどに対応したシンタックスハイライト
    -- 	-- neorgで使うと若干微妙かも。。。
    -- 	"lukas-reineke/headlines.nvim",
    -- 	dependencies = "nvim-treesitter/nvim-treesitter",
    -- 	config = true, -- or `opts = {}`
    -- 	lazy = true,
    -- 	ft = { "markdown" },
    -- },
    -- -- [end] language
}
