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

-- バッファを選択して CopilotChat を開く
function CopilotChatBuffer()
	require("CopilotChat").open({ selection = require("CopilotChat.select").buffer })
end

-- telescope を使ってアクションプロンプトを表示する
function ShowCopilotChatActionPrompt()
	local actions = require("CopilotChat.actions")
	require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end

-- キーマッピング
-- <C-c> で CopilotChat を開く
vim.api.nvim_set_keymap("n", "<C-c>", "<cmd>lua CopilotChatBuffer()<cr>", { noremap = true, silent = true })
-- <leader>ccp (Copilot Chat Prompt の略) でアクションプロンプトを表示する
vim.api.nvim_set_keymap(
	"n",
	"<leader><C-p>",
	"<cmd>lua ShowCopilotChatActionPrompt()<cr>",
	{ noremap = true, silent = true }
)
