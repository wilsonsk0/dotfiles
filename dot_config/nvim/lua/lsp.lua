return {
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = {
                "clangd",
                "lua_ls",
                "cmake",
                "pylsp",
                "rust_analyzer",
                "glsl_analyzer",
            },
            automatic_installation = true,
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = require("cmp_nvim_lsp").default_capabilities()
                    }
                end,
                ["clangd"] = function()
                    require("lspconfig").clangd.setup {
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        cmd = {
                            "clangd",
                            "--offset-encoding=utf-16",
                        },
                        filetypes = { "c", "cpp", "objcpp", "cuda" },
                    }
                end,
                ["pylsp"] = function()
                    require("lspconfig").pylsp.setup {
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
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
                end,
            }
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" }
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- null_ls.builtins.diagnostics.cmake_lint.with({ command = "cmakelint" }),
                    -- null_ls.builtins.formatting.cmake_format,
                    null_ls.builtins.diagnostics.codespell,
                    null_ls.builtins.diagnostics.commitlint,
                    null_ls.builtins.diagnostics.cppcheck,
                }
            })
        end,
    },
}
