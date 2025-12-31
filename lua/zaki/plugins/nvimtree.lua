return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- icons
  },
  config = function()
    -- REQUIRED: disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      hijack_netrw = true,

      view = {
        width = 30,
        side = "left",
      },

      renderer = {
        group_empty = true,
        highlight_git = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },

      update_focused_file = {
        enable = true,
        update_root = false,
      },

      actions = {
        open_file = {
          quit_on_open = false, -- IMPORTANT: keep tree open
          resize_window = false,
        },
      },
    })

    -- Toggle tree
    vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeToggle<CR>", { desc = "File tree" })
  end,
}

