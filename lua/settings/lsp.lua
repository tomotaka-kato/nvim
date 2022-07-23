-- LSP本体設定

local on_attach = function(client, bufnr)
    -- マッピング
    -- tami5/lspsaga.nvimを使ってUI表示を行う。
    -- コードアクション
    vim.cmd[[nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>]]
    vim.cmd[[vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>]]
    -- hover doc
    vim.cmd[[nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]]
    -- scroll hover doc or scroll in definition preview
    vim.cmd[[nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]]
    vim.cmd[[nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]]
    -- rename
    vim.cmd[[nnoremap <silent> <leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>]]
end

local lsp_installer = require "nvim-lsp-installer"
local lspconfig = require "lspconfig"
lsp_installer.setup()
for _, server in ipairs(lsp_installer.get_installed_servers()) do
  lspconfig[server.name].setup {
    on_attach = on_attach,
  }
end

-- 補完プラグイの設定
capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local cmp = require'cmp'
cmp.setup({
	window = {},
	mapping = cmp.mapping.preset.insert({
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

-- LSPのプログレス表示
require"fidget".setup{}

-- spellのための設定
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }
