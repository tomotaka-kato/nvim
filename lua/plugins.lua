vim.cmd[[packadd packer.nvim]]

require'packer'.startup(function(use)
    use{'wbthomason/packer.nvim', opt = true}
    -- LSP
    use('neovim/nvim-lspconfig')
    use("williamboman/nvim-lsp-installer")
    -- 補完
    use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/cmp-buffer")
	-- treesitter
	use('nvim-treesitter/nvim-treesitter')
	-- カッコの補完
	use('cohama/lexima.vim')
end)

require('lsp')
require('tree-sitter')
