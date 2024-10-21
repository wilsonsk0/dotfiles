return {
    -- theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        main = "catppuccin",
        lazy = false,
        priority = 1000,
        opts = {
            integrations = {
                gitsigns = true,
                mason = true,
                neotree = true,
                cmp = true,
                dap = true,
                dap_ui = true,
                which_key = true,
            },
        },
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    -- icons
    {
        "echasnovski/mini.icons",
        lazy = true,
        specs = {
            { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
        },
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
    -- buffer tabs along the top
    {
        'akinsho/bufferline.nvim',
        main = "bufferline",
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            vim.opt.termguicolors = true
            require("bufferline").setup({
                highlights = require("catppuccin.groups.integrations.bufferline").get(),
                options = {
                    indicator = { style = "underline" },
                    diagnostics = "nvim_lsp",
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "",
                            text_align = "left",
                            separator = true,
                        }
                    },
                    show_close_icon = false,
                    custom_filter = function(buf_number)
                        if vim.bo[buf_number].filetype ~= "qf" then
                            return true
                        end
                        return false
                    end,
                }
            })
        end,
    },
    -- info line along the bottom
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = "catppuccin",
            }
        },
    },
}
