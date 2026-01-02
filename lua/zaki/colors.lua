local M = {}

local theme_file = vim.fn.stdpath("data") .. "/colorscheme.txt"

function M.load()
  local f = io.open(theme_file, "r")
  if f then
    local theme = f:read("*l")
    f:close()
    if theme and theme ~= "" then
      pcall(vim.cmd.colorscheme, theme)
      return
    end
  end
  vim.cmd.colorscheme("tokyonight")
end

function M.save(theme)
  local f = io.open(theme_file, "w")
  if f then
    f:write(theme)
    f:close()
  end
end

return M

