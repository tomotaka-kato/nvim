local status, chat = pcall(require, "CopilotChat")
if not status then
	print("CopilotChat is not installed.")
	return
end

local select = require("CopilotChat.select")

chat.setup({
	mappings = {
		reset = {
			normal = "<leader><C-l>",
			insert = "<C-l>",
		},
	},
	prompts = {
		Fix = {
			prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
		},
		Optimize = {
			prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readablilty.",
		},
		Docs = {
			prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
		},
		Tests = {
			prompt = "/COPILOT_GENERATE Please generate tests for my code.",
		},
		DocCommentJa = {
			prompt = "/COPILOT_GENERATE ドキュメントコメントを日本語で記載してください。すでに記載されている場合、もしも実装と乖離がある場合には修正をお願いします。",
		},
		FixDiagnostic = {
			prompt = "Please assist with the following diagnostic issue in file:",
			selection = select.diagnostics,
		},
		Commit = {
			prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
			selection = select.gitdiff,
		},
		CommitStaged = {
			prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
			selection = function(source)
				return select.gitdiff(source, true)
			end,
		},
		CommitStagedJa = {
			prompt = "Write commit message for the change with commitizen convention in Japanese. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
			selection = function(source)
				return select.gitdiff(source, true)
			end,
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
vim.api.nvim_set_keymap(
	"v",
	"<leader><C-p>",
	"<cmd>lua ShowCopilotChatActionPrompt()<cr>",
	{ noremap = true, silent = true }
)
