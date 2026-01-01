return {
  "neovim/nvim-lspconfig",
  config = function()
    -- C / C++
    vim.lsp.config.clangd = {}
    vim.lsp.enable("clangd")

    -- Python
    vim.lsp.config.pyright = {}
    vim.lsp.enable("pyright")

    -- PHP
    vim.lsp.config.intelephense = {}
    vim.lsp.enable("intelephense")

    -- Go
    vim.lsp.config.gopls = {}
    vim.lsp.enable("gopls")
  end,
}

