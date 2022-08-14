local status, saga = pcall(require, 'lspsaga')
if not status then return end

saga.init_lsp_saga {
    server_filetype_map = {}
}



-- key maps
local opts = {noremap = true, silent = true}
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<cr>', opts)
vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga diagnostic_jump_prev<cr>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', opts)
vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<cr>', opts)
vim.keymap.set('n', '<leader>rn<cr>', '<Cmd>Lspsaga rename<cr>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<cr>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga preview_definition<cr>', opts)

-- Code actiona
local action = require('lspsaga.codeaction')
vim.keymap.set("n", "<leader>ca", action.code_action, { silent = true })
vim.keymap.set("v", "<leader>ca", function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
    action.range_code_action()
end, opts)

-- [begin] diagnosticをvirtual_textではなくhoverで表示するように変更
local diagnostic = require('lspsaga.diagnostic')
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
local diagnostic_hover_augroup_name = "lspconfig-diagnostic"
vim.api.nvim_set_option('updatetime', 500)
vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
vim.api.nvim_create_autocmd(
    { "CursorHold" },
    {
        group = diagnostic_hover_augroup_name,
        callback = function()
            diagnostic.show_cursor_diagnostics()
        end
    }
)
-- [end] diagnosticをvirtual_textではなくhoverで表示するように変更
