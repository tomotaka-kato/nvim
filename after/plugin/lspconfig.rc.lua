local status_lspkind, lspkind = pcall(require, 'lspkind')
local status_mason, mason = pcall(require, 'mason')
local status_lspconfig, mason_lspconfig = pcall(require, 'mason-lspconfig')
local status_nvim_lsp, nvim_lsp = pcall(require, "lspconfig")

if (not status_lspkind) then return end
if (not status_mason) then return end
if (not status_lspconfig) then return end
if (not status_nvim_lsp) then return end

-- LSPのプログレス表示
require "fidget".setup {}


mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- LSP本体設定

local on_attach = function(client, bufnr)
    -- formatting
    -- nul_lsのリンターには効かない？
    -- if client.server_capabilities.documentFormattingProvider then
    --     vim.api.nvim_command [[augroup Format]]
    --     vim.api.nvim_command [[autocmd! * <buffer>]]
    --     vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
    --     vim.api.nvim_command [[autogroup END]]
    -- end

    -- マッピング
    -- tami5/lspsaga.nvimを使ってUI表示を行う。
    -- コードアクション
    vim.cmd [[nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>]]
    vim.cmd [[vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>]]
    -- hover doc
    vim.cmd [[nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]]
    -- scroll hover doc or scroll in definition preview
    vim.cmd [[nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]]
    vim.cmd [[nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]]
    -- rename
    vim.cmd [[nnoremap <silent> <leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>]]
end

local setup_emmet = function()
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    nvim_lsp.emmet_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end

local setup_efm = function()
    -- Linter, Formatterはefmで行うのでその設定
    nvim_lsp.efm.setup {
        -- flags = {
        --     debounce_text_changes = 150,
        -- },
        init_options = { documentFormatting = true },
        filetypes = { "python" },
        settings = {
            rootMarkers = { ".git/" },
            languages = {
                python = {
                    { formatCommand = "black --quiet -", formatStdin = true }
                }
            }
        }
    }
end

local setup_cssls = function ()
    nvim_lsp.cssls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end

local setup_html = function()
    nvim_lsp.html.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        embeddedLanguages = {
            css = true,
            javascript = true
        },
        provideFormatter = true
    }
end


mason_lspconfig.setup_handlers({ function(server_name)
    if server_name == 'emmet' then
        setup_emmet()
    elseif server_name == 'efm' then
        setup_efm()
    elseif server_name == 'html' then
        setup_html()
    elseif server_name == 'cssls' then
        setup_cssls()
    else
        nvim_lsp[server_name].setup {
            on_attach = on_attach,
        }
    end
end })

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


-- Linter,  formatter
local mason_package = require("mason-core.package")
local mason_registry = require("mason-registry")
local null_ls = require("null-ls")

local null_sources = {}

for _, package in ipairs(mason_registry.get_installed_packages()) do
    local package_categories = package.spec.categories[1]
    if package_categories == mason_package.Cat.Formatter then
        table.insert(null_sources, null_ls.builtins.formatting[package.name])
    end
    if package_categories == mason_package.Cat.Linter then
        table.insert(null_sources, null_ls.builtins.diagnostics[package.name])
    end
end

null_ls.setup({
    sources = null_sources,
})

