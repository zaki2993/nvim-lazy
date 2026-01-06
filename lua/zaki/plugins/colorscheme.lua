return {
  -- 🔥 Main / default (loads first)
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("zaki.colors").load()
    end,
  },

  -- 🌸 Smooth & aesthetic
  { "catppuccin/nvim", name = "catppuccin", priority = 900 },

  -- 🌊 Japanese ink style
  { "rebelot/kanagawa.nvim", priority = 850 },

  -- 🌹 Elegant & minimal
  { "rose-pine/neovim", name = "rose-pine", priority = 820 },

  -- 🌲 Calm, green-forward
  { "sainnhe/everforest", priority = 800 },

  -- 🍂 Warm & classic
  { "ellisonleao/gruvbox.nvim", priority = 780 },

  -- ⚡ IDE-like, high contrast
  { "navarasu/onedark.nvim", priority = 760 },

  -- ❄️ Cool & blue-heavy
  { "shaunsingh/nord.nvim", priority = 740 },

  -- 🦊 Highly customizable family
  { "EdenEast/nightfox.nvim", priority = 720 },

  -- 🌞 Modern solarized
  { "craftzdog/solarized-osaka.nvim", priority = 700 },
}

