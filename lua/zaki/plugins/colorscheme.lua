return {

  -- Tokyo Night (default)
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- Catppuccin (very clean, modern)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 900,
  },

  -- Gruvbox (classic, very readable)
  {
    "ellisonleao/gruvbox.nvim",
    priority = 800,
  },

  -- OneDark (VSCode-like)
  {
    "navarasu/onedark.nvim",
    priority = 700,
  },

}

