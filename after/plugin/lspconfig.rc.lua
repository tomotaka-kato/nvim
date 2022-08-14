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
    -- 保存時に自動でフォーマットをかける
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
    vim.api.nvim_command [[augroup END]]
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

