local status_nullls, none_ls = pcall(require, "null-ls")
local status_package, mason_package = pcall(require, "mason-core.package")
local status_registory, mason_registry = pcall(require, "mason-registry")

if not status_nullls then
	print("none-ls is not installed.")
	return
end
if not status_package then
	print("mason-core is not installed.")
	return
end
if not status_registory then
	print("mason-registry is not installed.")
	return
end

local null_sources = {}

-- null-lsに対象のパッケージがあるかどうかをチェックする関数
local function is_package_in_null_ls_formatting(package_name)
	return none_ls.builtins.formatting[package_name] ~= nil
end

local function is_package_in_null_ls_diagnostics(package_name)
	return none_ls.builtins.diagnostics[package_name] ~= nil
end

-- 既存の条件にnull-lsのチェックを追加
for _, package in ipairs(mason_registry.get_installed_packages()) do
	local package_categories = package.spec.categories[1]
	if package_categories == mason_package.Cat.Formatter and is_package_in_null_ls_formatting(package.name) then
		table.insert(null_sources, none_ls.builtins.formatting[package.name])
	end
	if package_categories == mason_package.Cat.Linter and is_package_in_null_ls_diagnostics(package.name) then
		table.insert(null_sources, none_ls.builtins.diagnostics[package.name])
	end
end

-- table.insert(
--   null_sources, require("none-ls.formatting.jq")
-- )

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"
none_ls.setup({
	sources = null_sources, -- {
	-- null_sources,
	-- require("none-ls.formatting.jq")
	-- },
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<Leader>=", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })

			-- format on save
			-- TODO: language毎に設定するかを変える？
			vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
			vim.api.nvim_create_autocmd(event, {
				buffer = bufnr,
				group = group,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, async = async })
				end,
				desc = "[lsp] format on save",
			})
		end

		if client.supports_method("textDocument/rangeFormatting") then
			vim.keymap.set("x", "<Leader>=", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })
		end
	end,
	diagnostic_config = {
		-- see :help vim.diagnostic.config()
		underline = true,
		virtual_text = true,
		signs = true,
		update_in_insert = false,
		severity_sort = true,
	},
})
