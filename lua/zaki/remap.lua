-- lua/zaki/remap.lua (safe, recommended)

-- 1. Globals
vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 2. Core Keymaps (safe, plugin-free)
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<Esc>", "<Esc>l", opts) -- Exit insert and move right
map("n", "<C-j>", "<C-d>", opts)
map("n", "<C-k>", "<C-u>", opts)
map({ "n", "v" }, "gg", "gg0", opts)
map({ "n", "v" }, "G", "G$", opts)

-- 3. LSP: use LspAttach to set buffer-local mappings (put this in remap so it's loaded early)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local bufopts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)            -- hover
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
    -- diagnostics popup (cursor)
    vim.keymap.set("n", "<leader>xs", function()
      vim.diagnostic.open_float(nil, { scope = "cursor", focusable = true })
    end, bufopts)
  end,
})

-- 4. Run current file (robust)
-- Handles java packages by reading `package` line and running `javac -d .` then `java <fqcn>`
local function detect_package()
  for i = 1, math.min(40, vim.api.nvim_buf_line_count(0)) do
    local line = vim.api.nvim_buf_get_lines(0, i-1, i, false)[1]
    if not line then break end
    local pkg = line:match("^%s*package%s+([%w%.]+);")
    if pkg then return pkg end
  end
  return nil
end

local function run_in_terminal(cmd)
  -- open at bottom to avoid messing up windows
  vim.cmd("botright split | resize 12 | terminal " .. cmd)
  vim.cmd("startinsert")
end

map("n", "<leader>r", function()
  vim.cmd("w")
  local ft = vim.bo.filetype
  local file = vim.fn.expand("%")
  local name = vim.fn.expand("%:t:r")
  local cmd = ""

  if ft == "python" then
    cmd = "python3 " .. file
  elseif ft == "c" then
    cmd = "gcc " .. file .. " -o " .. name .. " && clear && ./" .. name
  elseif ft == "cpp" then
    cmd = "g++ " .. file .. " -o " .. name .. " && clear && ./" .. name
  elseif ft == "dart" then
    cmd = "dart run " .. file
  elseif ft == "java" then
    -- compile to package-correct directories and run fully-qualified name
    local pkg = detect_package()
    local fqcn = name
    local compile = string.format("javac -d . %s", file)
    if pkg then
      fqcn = pkg .. "." .. name
    end
    cmd = string.format("%s && clear && java -cp . %s", compile, fqcn)
  else
    print("No run command for filetype: " .. ft)
    return
  end

  if cmd ~= "" then run_in_terminal(cmd) end
end, { desc = "Run current file (smart)" })

-- 5. TMUX helpers (safe)
map("n", "<leader>fr", function()
  vim.fn.system("tmux send-keys -t :2 r")
  print("Reload sent to Window 2")
end, { desc = "Tmux: Reload" })

map("n", "<leader>fhr", function()
  vim.fn.system("tmux send-keys -t :2 R")
  print("Restart sent to Window 2")
end, { desc = "Tmux: Restart" })

-- 6. Floating-window Esc close: make buffer-local when entering a floating window
vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    local ok, win_config = pcall(vim.api.nvim_win_get_config, 0)
    if not ok or not win_config then return end
    if win_config and win_config.relative and win_config.relative ~= "" then
      -- buffer-local mapping to close this float with Esc
      vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = true, silent = true })
    end
  end,
})

-- 7. Shortcut for diagnostics UI (Trouble) kept separately: <leader>xx etc. (configured in plugins)

