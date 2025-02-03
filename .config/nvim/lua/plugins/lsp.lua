return {
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason").setup()
            local m_lspconfig = require("mason-lspconfig")
            m_lspconfig.setup {
                ensure_installed = { "lua_ls" },
            }
            m_lspconfig.setup_handlers {
                function(server_name)
                    local capabilities = require("cmp_nvim_lsp").default_capabilities()
                    require("lspconfig")[server_name].setup { capabilities = capabilities }
                end
            }
        end,
    },
    "neovim/nvim-lspconfig",
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                {path = "${3rd}/luv/library", words = {"vim%.uv"}},
            },
        },
    },
}
