local status_lspkind, lspkind = pcall(require, 'lspkind')
local status_mason, mason = pcall(require, 'mason')
local status_lspconfig, mason_lspconfig = pcall(require, 'mason-lspconfig')
local status_nvim_lsp, nvim_lsp = pcall(require, "lspconfig")
local status_fidget, fidget = pcall(require, 'fidget')

if not status_lspkind then
    print('lspkind is not installed.')
    return
end
if not status_mason then
    print('mason is not installed.')
    return
end
if not status_lspconfig then
    print('mason-lspconfig is not installed.')
    return
end
if not status_nvim_lsp then
    print('lspconfig is not installed.')
    return
end
if not status_fidget then
    print('fidget is not installed.')
    return
end

-- LSPのプログレス表示
fidget.setup {}


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
    -- vim.api.nvim_command [[augroup Format]]
    -- vim.api.nvim_command [[autocmd! * <buffer>]]
    -- vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
    -- vim.api.nvim_command [[augroup END]]

    -- キーマップ
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)
    if status_signature then -- 入力中にシグネチャを表示する
        signature.on_attach({
            bind = true,
            handler_opts = {
                border = "rounded"
            }
        }, bufnr)
    end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local setup_emmet = function()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    nvim_lsp.emmet_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end

-- null-lsに移行したのでコメントアウト
-- ただnull-lsはアーカイブされるので戻ってくるかも？
-- local setup_efm = function()
--     -- Linter, Formatterはefmで行うのでその設定
--     nvim_lsp.efm.setup {
--         -- flags = {
--         --     debounce_text_changes = 150,
--         -- },
--         init_options = { documentFormatting = true },
--         filetypes = { "python" },
--         settings = {
--             rootMarkers = { ".git/" },
--             languages = {
--                 python = {
--                     { formatCommand = "black --quiet -", formatStdin = true }
--                 }
--             }
--         }
--     }
-- end

local setup_cssls = function()
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

-- luaの設定
-- 今はsumneko_luaではなくてlua_lsになってるっぽい
local setup_lua_ls = function()
    nvim_lsp.lua_ls.setup {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {'vim'} -- vimなんてglobalにないよと怒られるので無視する
                }
            }
        }
    }
end

mason_lspconfig.setup_handlers({ function(server_name)
  if server_name == 'emmet' then
    setup_emmet()
  elseif server_name == 'html' then
    setup_html()
  elseif server_name == 'cssls' then
    setup_cssls()
  elseif server_name == 'lua_ls' then
    setup_lua_ls()
  else
    nvim_lsp[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
  end
end })
