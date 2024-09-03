local status, chat = pcall(require, "CopilotChat")
if not status then
	print("CopilotChat is not installed.")
	return
end

local prompts = require("CopilotChat.prompts")
local select = require("CopilotChat.select")

chat.setup({
	debug = false, -- Enable debug logging
	proxy = nil, -- [protocol://]host[:port] Use this proxy
	allow_insecure = false, -- Allow insecure server connections

	system_prompt = prompts.COPILOT_INSTRUCTIONS, -- System prompt to use
	model = "gpt-4o", -- GPT model to use, 'gpt-3.5-turbo', 'gpt-4', or 'gpt-4o'
	temperature = 0.1, -- GPT temperature

	question_header = "## User ", -- Header to use for user questions
	answer_header = "## Copilot ", -- Header to use for AI answers
	error_header = "## Error ", -- Header to use for errors
	separator = "───", -- Separator to use in chat

	show_folds = true, -- Shows folds for sections in chat
	show_help = true, -- Shows help message as virtual lines when waiting for user input
	auto_follow_cursor = true, -- Auto-follow cursor in chat
	auto_insert_mode = false, -- Automatically enter insert mode when opening window and on new prompt
	insert_at_end = false, -- Move cursor to end of buffer when inserting text
	clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
	highlight_selection = true, -- Highlight selection in the source buffer when in the chat window

	context = nil, -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
	history_path = vim.fn.stdpath("data") .. "/copilotchat_history", -- Default path to stored history
	callback = nil, -- Callback to use when ask response is received

	-- default selection (visual or line)
	selection = function(source)
		return select.visual(source) or select.line(source)
	end,
	mappings = {
		reset = {
			normal = "<leader><C-l>",
			insert = "<C-l>",
		},
		complete = {
			detail = "Use @<Tab> or /<Tab> for options.",
			insert = "<Tab>",
		},
		close = {
			normal = "q",
			insert = "<C-c>",
		},
		submit_prompt = {
			normal = "<CR>",
			insert = "<C-s>",
		},
		accept_diff = {
			normal = "<C-y>",
			insert = "<C-y>",
		},
		yank_diff = {
			normal = "gy",
			register = '"',
		},
		show_diff = {
			normal = "gd",
		},
		show_system_prompt = {
			normal = "gp",
		},
		show_user_selection = {
			normal = "gs",
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
			prompt = "/COPILOT_GENERATE ドキュメントコメントを日本語で記載してください。すでに記載されている場合、もしも実装と乖離があれば修正してください。",
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
				print("source", source)
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
