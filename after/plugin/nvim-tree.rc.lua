local status, tree = pcall(require, "nvim-tree")

if not status then
	print("nvim-tree.lua is note installed")
	return
end

local M = {}
local function opts(desc, bufnr)
	return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

local api = require("nvim-tree.api")

function M.on_attach(bufnr)
	-- vim.keymap.set("n", "<C-e>", ":NvimTreeToggle<CR>", opts("tree toggle"))
	vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD", bufnr))
	-- vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
	vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info", bufnr))
	vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename", bufnr))
	vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab", bufnr))
	vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split", bufnr))
	vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split", bufnr))
	vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory", bufnr))
	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open", bufnr))
	vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview", bufnr))
	vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling", bufnr))
	vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling", bufnr))
	vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command", bufnr))
	vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up", bufnr))
	vim.keymap.set("n", "a", api.fs.create, opts("Create", bufnr))
	vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked", bufnr))
	vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer", bufnr))
	vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy", bufnr))
	vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean", bufnr))
	vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git", bufnr))
	vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git", bufnr))
	vim.keymap.set("n", "d", api.fs.remove, opts("Delete", bufnr))
	vim.keymap.set("n", "D", api.fs.trash, opts("Trash", bufnr))
	vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All", bufnr))
	vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename", bufnr))
	vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic", bufnr))
	vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic", bufnr))
	vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter", bufnr))
	vim.keymap.set("n", "f", api.live_filter.start, opts("Filter", bufnr))
	vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help", bufnr))
	vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path", bufnr))
	vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles", bufnr))
	vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore", bufnr))
	vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling", bufnr))
	vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling", bufnr))
	vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark", bufnr))
	vim.keymap.set("n", "o", api.node.open.edit, opts("Open", bufnr))
	vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker", bufnr))
	vim.keymap.set("n", "p", api.fs.paste, opts("Paste", bufnr))
	vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory", bufnr))
	vim.keymap.set("n", "q", api.tree.close, opts("Close", bufnr))
	vim.keymap.set("n", "r", api.fs.rename, opts("Rename", bufnr))
	vim.keymap.set("n", "R", api.tree.reload, opts("Refresh", bufnr))
	vim.keymap.set("n", "s", api.node.run.system, opts("Run System", bufnr))
	vim.keymap.set("n", "S", api.tree.search_node, opts("Search", bufnr))
	vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden", bufnr))
	vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse", bufnr))
	vim.keymap.set("n", "x", api.fs.cut, opts("Cut", bufnr))
	vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name", bufnr))
	vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path", bufnr))
	vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open", bufnr))
	vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD", bufnr))
end

tree.setup({
	on_attach = M.on_attach,
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_set_keymap("n", "<C-e>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
