return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "petertriho/cmp-git",
            "nvim-lua/plenary.nvim",
        },
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0,
            })
        end,
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = {
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({select = true }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp"},
                }, {
                    {name = "buffer"},
                })
            })

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "git" },
                }, {
                    { name = "buffer" },
                })
            })
            require("cmp_git").setup{}

            cmp.setup.cmdline({"/", "?"}, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    {name = "buffer" },
                }
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    {name = "path"}
                }, {
                    {name = "cmdline"},
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
        end,
    },
}
