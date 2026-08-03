local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
	print("nvim-treesitter is not installed.")
	return
end

local ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }

-- markdownでcsharpと記載されている場合にもc_sharpのparserを使うようにする
vim.treesitter.language.register("c_sharp", "csharp")

if ts.setup then
	ts.setup({
		install_dir = vim.fn.stdpath("data") .. "/site",
	})

	ts.install(ensure_installed)

	local group = vim.api.nvim_create_augroup("vimrc_treesitter_start", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = "*",
		callback = function(args)
			pcall(vim.treesitter.start, args.buf)
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = { "c", "cpp", "css", "go", "javascript", "lua", "python", "rust", "typescript", "typescriptreact" },
		callback = function()
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	})
else
	local status, configs = pcall(require, "nvim-treesitter.configs")
	if not status then
		return
	end

	configs.setup({
		ensure_installed = ensure_installed,
		sync_install = false,
		auto_install = false,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["iB"] = "@block.inner",
					["aB"] = "@block.outer",
				},
			},
		},
	})
end
