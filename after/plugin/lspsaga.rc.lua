local status, saga = pcall(require, 'lspsaga')
if not status then
  print('lspsaga is not installed.')
  return
end

saga.setup ({
  code_action = {
    num_shortcut = true,
    show_server_name = false,
    extend_gitsigns = true,
    keys = {
      -- string | table type
      quit = {"q", "<Esc>"},
      exec = "<CR>",
    },
  },
   lightbulb = {
    enable = true,
    enable_in_insert = true,
    sign = true,
    sign_priority = 40,
    virtual_text = false,
  },
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
keymap.set("n", "<leader>ca", ":Lspsaga code_action<cr>", { silent = true })

-- [begin] diagnosticをvirtual_textではなくhoverで表示するように変更
-- lsp_lineを使ってみてるのでいったんオフにする -> ちょいと画面がごちゃごちゃするのでこっちに戻してみる
vim.api.nvim_set_option('updatetime', 300)
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    command = 'Lspsaga show_cursor_diagnostics ++unfocus',
})
-- [end] diagnosticをvirtual_textではなくhoverで表示するように変更
