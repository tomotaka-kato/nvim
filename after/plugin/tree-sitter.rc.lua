local status, ts = pcall(require, 'nvim-treesitter.configs')
if not status then
    print('nvim-treesitter is not installed.')
    return
end

ts.setup {
    -- A list of parser names, or "all"
    -- markdownとmarkdown_inlineはdocの表示とかに使ってるっぽい
    ensure_installed = { 'lua', 'markdown', 'markdown_inline' },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = {"all"},

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {'vue', 'typescriptreact'}, -- vueはtree-sitterでのハイライトがうまく効かないのでOFFにする

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    context_commentstring = {
        enable = true
    },
    yati = {
        enable = true,
        disable = { 'vue' } -- treesitterのindentがイケてないやつはOFFにする
    },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["iB"] = "@block.inner",
                ["aB"] = "@block.outer",
            },
        },
    },
}

vim.api.nvim_set_keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>', { noremap = true })
vim.api.nvim_set_keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>', { noremap = true })
vim.api.nvim_set_keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', { noremap = true })
vim.api.nvim_set_keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', { noremap = true })
