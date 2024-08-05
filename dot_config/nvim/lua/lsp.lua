return {
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "lua_ls", "cmake", "pylsp", "rust_analyzer" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.clangd.setup { capabilities = capabilities }
            lspconfig.lua_ls.setup { capabilities = capabilities }
            lspconfig.cmake.setup { capabilities = capabilities }
            lspconfig.pylsp.setup {
                filetypes = { "python" },
                settings = {
                    pylsp = {
                        plugins = {
                            black = {
                                enabled = true,
                                line_length = 120,
                            },
                            isort = {
                                enabled = true,
                            },
                        }
                    }
                }
            }
            lspconfig.rust_analyzer.setup { capabilities = capabilities }
        end,
    },
}
