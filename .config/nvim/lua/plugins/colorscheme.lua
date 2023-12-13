return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon", transparent = true, styles = { sidebars = "transparent", floats = "transparent" } },
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
