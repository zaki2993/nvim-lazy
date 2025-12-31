return {
  "neovim/nvim-lspconfig",
  config = function()
    -- clangd
    vim.lsp.config.clangd = {}
    vim.lsp.enable("clangd")

    -- Java (jdtls)
    vim.lsp.config.jdtls = {}
    vim.lsp.enable("jdtls")
  end,
}

