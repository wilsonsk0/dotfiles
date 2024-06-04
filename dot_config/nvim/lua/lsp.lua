return {
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "cmake" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = {} -- require("cmp_nvim_lsp").default_capabilities()

            lspconfig.clangd.setup { capabilities = capabilities }
            lspconfig.lua_ls.setup { capabilities = capabilities }
            lspconfig.cmake.setup { capabilities = capabilities }
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts) require 'lsp_signature'.setup(opts) end
    },
}
