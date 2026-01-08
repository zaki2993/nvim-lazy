return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local mlc = require("mason-lspconfig")

            -- ensure servers are installed via Mason (use names from mason registry)
            mlc.setup({
                ensure_installed = { "lua_ls", "tsserver", "jdtls" },
            })

            -- start servers using the new Neovim LSP API when they are available
            -- handler gets the server name as registered in mason-lspconfig
            mlc.setup_handlers({
                function(server_name)
                    -- prefer direct match: server_name should equal a key in vim.lsp.config
                    if vim.lsp.config[server_name] then
                        vim.lsp.start(vim.lsp.config[server_name])
                        return
                    end

                    -- special-case mapping: mason may install 'tsserver' but we configured 'ts_ls'
                    if server_name == "tsserver" and vim.lsp.config["ts_ls"] then
                        vim.lsp.start(vim.lsp.config["ts_ls"])
                        return
                    end

                    -- fallback: try protected require to avoid runtime errors
                    -- (no-op if there's nothing to start)
                end,
            })
        end,
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "java-debug-adapter", "java-test" },
            })
        end,
    },

    {
        "mfussenegger/nvim-jdtls",
        dependencies = { "mfussenegger/nvim-dap" },
    },

    {
        "neovim/nvim-lspconfig",
        -- ensure mason-lspconfig is loaded before this config runs (lazy.nvim will honor this)
        dependencies = { "williamboman/mason-lspconfig.nvim", "williamboman/mason.nvim" },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- declare server configs using the new API (vim.lsp.config)
            vim.lsp.config.lua_ls = {
                capabilities = capabilities,
                -- additional lua_ls settings can go here
            }

            -- we configure ts_ls (nvim-lspconfig's new name); mason installs 'tsserver'
            vim.lsp.config.ts_ls = {
                capabilities = capabilities,
                cmd = { "typescript-language-server", "--stdio" },
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            }

            vim.lsp.config.jdtls = {
                capabilities = capabilities,
                -- jdtls-specific settings can go here
            }

            -- Keymaps (safe to set here)
            vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
            vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
            vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "[C]ode Goto [R]eferences" })
            vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, { desc = "[C]ode Goto [I]mplementations" })
            vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
            vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
        end,
    },
}

