-- 1. Globals
vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 2. General Keymaps
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
-- Exit insert mode and move one character to the right (Your preference)
map("i", "<Esc>", "<Esc>l", opts)

-- Navigation adjustments
map("n", "<C-j>", "<C-d>", opts) -- Half-page down
map("n", "<C-k>", "<C-u>", opts) -- Half-page up

-- Force gg and G to go to start/end of line
map({ "n", "v" }, "gg", "gg0", opts)
map({ "n", "v" }, "G", "G$", opts)

-- 3. Plugin Keymaps (Safe versions)
-- NvimTree
map("n", "<leader>pv", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer" })

-- Telescope (Using commands to prevent startup errors)
map("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Search in Buffer" })
map("n", "<leader>ps", "<cmd>Telescope live_grep<CR>", { desc = "Search Project" })

-- LSP (Basic mappings)
map("n", "<", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<leader>fa", vim.lsp.buf.code_action, { desc = "Code Action" })

-- 4. Custom Functions

-- Function to run commands in a split terminal
local function run_in_terminal(cmd)
  vim.cmd("10split | terminal " .. cmd)
  vim.api.nvim_command("startinsert")
end

-- <leader>r: Run current file based on extension
map("n", "<leader>r", function()
  vim.cmd("w")
  local ft = vim.bo.filetype
  local file = vim.fn.expand("%")
  local name = vim.fn.expand("%:r")
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
    cmd = "javac " .. file .. " && clear && java " .. name
  else
    print("No run command for filetype: " .. ft)
    return
  end

  if cmd ~= "" then
    run_in_terminal(cmd)
  end
end, { desc = "Run current file" })

-- 5. TMUX Integration
map("n", "<leader>fr", function()
    vim.fn.system("tmux send-keys -t :2 r")
    print("Reload sent to Window 2")
end, { desc = "Tmux: Reload" })

map("n", "<leader>fhr", function()
    vim.fn.system("tmux send-keys -t :2 R")
    print("Restart sent to Window 2")
end, { desc = "Tmux: Restart" })

-- 6. Helper Autocommands
-- Close floating windows (like LSP hover) with Esc
vim.api.nvim_create_autocmd("WinEnter", {
    callback = function()
        local win_config = vim.api.nvim_win_get_config(0)
        if win_config.relative ~= "" then
            map("n", "<Esc>", ":close<CR>", { buffer = true, silent = true })
        end
    end
})
