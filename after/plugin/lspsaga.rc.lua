local status, saga = pcall(require, 'lspsaga')
if not status then
    print('lspsaga is not installed.')
    return
end

saga.init_lsp_saga ({
    border_style = 'single',
    server_filetype_map = {}
})

local keymap = vim.keymap

-- key maps
local opts = { noremap = true, silent = true }
keymap.set('n', ';dj', '<Cmd>Lspsaga diagnostic_jump_next<cr>', opts)
keymap.set('n', ';dk', '<Cmd>Lspsaga diagnostic_jump_prev<cr>', opts)
keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', opts)
keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<cr>', opts)
keymap.set('n', '<leader>rn<cr>', '<Cmd>Lspsaga rename<cr>', opts)
keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<cr>', opts)
keymap.set('n', 'gp', '<Cmd>Lspsaga preview_definition<cr>', opts)

-- Code actiona
local action = require('lspsaga.codeaction')
keymap.set("n", "<leader>ca", action.code_action, { silent = true })
keymap.set("v", "<leader>ca", function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
    action.range_code_action()
end, opts)

-- LSP標準のdiagnosticをvirtual textで表示しない
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)

-- [begin] diagnosticをvirtual_textではなくhoverで表示するように変更
local diagnostic = require('lspsaga.diagnostic')
local diagnostic_hover_augroup_name = "lspconfig-diagnostic"
vim.api.nvim_set_option('updatetime', 300)
vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
vim.api.nvim_create_autocmd(
    { "CursorHold" },
    {
        group = diagnostic_hover_augroup_name,
        callback = diagnostic.show_cursor_diagnostics
    }
)
-- [end] diagnosticをvirtual_textではなくhoverで表示するように変更
