vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    require("zaki.colors").save(vim.g.colors_name)
  end,
})

