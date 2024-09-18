return {
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "lua_ls",
                    "cmake",
                    "pylsp",
                    "rust_analyzer",
                    "glslls",
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.clangd.setup {
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--offset-encoding=utf-16",
                }
            }
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
    {
        "nvimtools/none-ls.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.code_actions.gitrebase,
                    null_ls.builtins.diagnostics.cmake_lint,
                    null_ls.builtins.formatting.cmake_format,
                    null_ls.builtins.diagnostics.codespell,
                }
            })
        end,
    },
}
