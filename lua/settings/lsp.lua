local lspkind = require('lspkind')

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

local function on_cursor_hold()
  if vim.lsp.buf.server_ready() then
    vim.diagnostic.open_float()
  end
end

-- [begin] diagnosticをvirtual_textではなくhoverで表示するように変更
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
local diagnostic_hover_augroup_name = "lspconfig-diagnostic"
vim.api.nvim_set_option('updatetime', 500)
vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, { group = diagnostic_hover_augroup_name, callback = on_cursor_hold })
-- [end] diagnosticをvirtual_textではなくhoverで表示するように変更

-- 補完プラグイの設定
capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local cmp = require'cmp'
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
	window = {},
	mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- ['<CR>'] = cmp.mapping.confirm({ select = true })
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'path' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'ultisnips' },
	}, {
		{ name = 'buffer' },
	}),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        })
    }

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


-- 言語ごとの設定
-- 以下に設定項目が書いてある。
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
if not lspconfig.emmet_ls then
  lspconfig.emmet_ls = {
    default_config = {
      cmd = { 'emmet_ls', '--stdio' };
      filetypes = {
        'html',
        'css',
        'scss',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'haml',
        'xml',
        'xsl',
        'pug',
        'slim',
        'sass',
        'stylus',
        'less',
        'sss',
        'hbs',
        'handlebars',
      };
      root_dir = function(fname)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end

lspconfig.emmet_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
 }
require'lspconfig'.cssls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
require'lspconfig'.html.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    embeddedLanguages = {
        css =true,
        javascript = true
    },
    provideFormatter = true
}

-- UltiSnipsのマッピング
vim.g.UltiSnipsExpandTrigger="<Enter>"
vim.cmd[[let g:UltiSnipsJumpForwardTrigger="<c-n>"]]
vim.cmd[[let g:UltiSnipsJumpBackwardTrigger="<c-p>"]]


-- LSPのプログレス表示
require"fidget".setup{}

