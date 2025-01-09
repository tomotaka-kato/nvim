local hop = require("hop")
hop.setup({ keys = "etovxqpdygfblzhckisuran" })
vim.api.nvim_set_keymap("", "<leader>w", "<cmd>HopWord<CR>", { noremap = true })
vim.api.nvim_set_keymap("", "<leader>l", "<cmd>HopLineStart<CR>", { noremap = true })
