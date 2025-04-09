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
                    local on_attach = function(_, bufnr)
                        require("which-key").add({
                            { "<leader>l",  group = "lsp" },
                            { "<leader>la", vim.lsp.buf.code_action,     desc = "code action",            mode = { "n", "v" } },
                            { "<leader>lf", vim.lsp.buf.format,          desc = "format",                 mode = "n" },
                            { "<leader>lR", vim.lsp.buf.rename,          desc = "rename",                 mode = { "n", "v" } },
                            { "<leader>ld", vim.lsp.buf.definition,      desc = "jump to definition",     mode = { "n", "v" } },
                            { "<leader>lo", vim.lsp.buf.document_symbol, desc = "show outline",           mode = "n" },
                            { "<leader>lr", vim.lsp.buf.references,      desc = "show references",        mode = { "n", "v" } },
                            { "<leader>lc", vim.lsp.buf.incoming_calls,  desc = "show calls" },
                            { "<leader>lt", vim.lsp.buf.type_definition, desc = "jump to type definition" },
                            { "<leader>lh", vim.lsp.buf.hover,           desc = "hover" },
                        }, { buffer = bufnr, noremap = true, silent = true })

                        -- local client = vim.lsp.get_clients({ name = server_name })[1]
                        -- if client.supports_method("textDocument/hover") then
                        --     vim.api.nvim_create_autocmd("CursorHold", {
                        --         pattern = "*",
                        --         callback = vim.lsp.buf.hover,
                        --     })
                        -- end
                    end
                    require("lspconfig")[server_name].setup { capabilities = capabilities, on_attach = on_attach }
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
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
