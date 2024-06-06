local status, chat = pcall(require, "CopilotChat")
if not status then
	print("CopilotChat is not installed.")
	return
end

chat.setup({
	mappings = {
		reset = {
			normal = "<leader><C-l>",
			insert = "<C-l>",
		},
	},
})

function CopilotChatBuffer()
	require("CopilotChat").open({ selection = require("CopilotChat.select").buffer })
end

vim.api.nvim_set_keymap("n", "<leader>ccb<cr>", "<cmd>lua CopilotChatBuffer()<cr>", { noremap = true, silent = true })
