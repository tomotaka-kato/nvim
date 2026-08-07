require("tokyonight").setup({
  style = "night",
  transparent = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    sidebars = "dark", -- transparentよりも色がついてる方が見やすい
    floats = "dark", -- transparentよりも色がついてる方が見やすい
  },
})
vim.cmd.colorscheme("tokyonight")
