-- LSP本体設定
local lsp_installer = require "nvim-lsp-installer"
local lspconfig = require "lspconfig"
lsp_installer.setup()
for _, server in ipairs(lsp_installer.get_installed_servers()) do
  lspconfig[server.name].setup {
    on_attach = on_attach,
  }
end

-- マッピング
-- LSPの関数に関してはこちらに載ってるのを参考にできる。
-- https://github.com/neovim/nvim-lspconfig
vim.cmd[[nnoremap <silent> <leader>ac <cmd>lua vim.lsp.buf.code_action()<CR>]]
local bufopts = { noremap=true, silent=true}
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

-- 補完プラグイの設定
capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local cmp = require'cmp'
cmp.setup({
	window = {},
	mapping = cmp.mapping.preset.insert({
		-- ["<C-p>"] = cmp.mapping.select_prev_item(),
		-- ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ['<CR>'] = cmp.mapping.confirm({ select = true })
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'path' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'spell' }
	}, {
		{ name = 'buffer' },
	})
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "nvim_lsp_document_symbol" },
		-- { name = "cmdline_history" },
		{ name = "buffer" },
	}, {}),
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
        { name = 'buffer' }
	}
})

-- 補完にアイコンをつける
local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    })
  }
}

-- spellのための設定
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }
