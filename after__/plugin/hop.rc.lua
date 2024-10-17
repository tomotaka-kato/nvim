local status, hop = pcall(require, "hop")
if not status then
	print("hop is not installed")
	return
end

hop.setup({ keys = "etovxqpdygfblzhckisuran" })
vim.api.nvim_set_keymap("", "<leader>w", "<cmd>HopWord<CR>", { noremap = true })
vim.api.nvim_set_keymap("", "<leader>l", "<cmd>HopLineStart<CR>", { noremap = true })
