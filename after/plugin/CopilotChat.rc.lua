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

-- 選択範囲に対して CopilotChat を開く
function CopilotChatQuich()
	require("CopilotChat").open({ selection = require("CopilotChat.select").visual })
end

-- telescope を使ってアクションプロンプトを表示する
function ShowCopilotChatActionPrompt()
	local actions = require("CopilotChat.actions")
	require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end

-- キーマッピング
-- <C-c> で CopilotChat を開く
vim.api.nvim_set_keymap("n", "<C-c>", "<cmd>lua CopilotChatQuich()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-c>", "<Esc><cmd>lua CopilotChatQuich()<cr>", { noremap = true, silent = true })
-- <leader><C-p> でアクションプロンプトを表示する
vim.api.nvim_set_keymap(
	"n",
	"<leader><C-p>",
	"<cmd>lua ShowCopilotChatActionPrompt()<cr>",
	{ noremap = true, silent = true }
)
