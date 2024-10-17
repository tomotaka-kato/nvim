require("tokyonight").setup({
  style = "night",
  transparent = true,
  commentStyle = "italic",
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    sidebars = "dark", -- transparentよりも色がついてる方が見やすい
    floats = "dark", -- transparentよりも色がついてる方が見やすい
  },
  sidebars = { "qf", "vista_kind", "terminal", "nvim-tree" },
})
vim.cmd.colorscheme("tokyonight")
