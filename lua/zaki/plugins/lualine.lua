return {

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("zaki.colors").load()
    end,
  },

  { "catppuccin/nvim", name = "catppuccin", priority = 900 },
  { "ellisonleao/gruvbox.nvim", priority = 800 },
  { "navarasu/onedark.nvim", priority = 700 },

}

