require("lazy").setup({
    {
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup()
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-telescope/telescope-ui-select.nvim'
        },
        config = function()
            local telescope = require('telescope')
            telescope.setup {
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown {}
                    },
                },
            }

            telescope.load_extension('ui-select')
        end,
    },
    { 'voldikss/vim-floaterm' },
    -- theme
    {
        "catppuccin/nvim",
        name = "catpuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                integrations = {
                    gitsigns = true,
                    mason = true,
                    neotree = true,
                    cmp = true,
                    dap = true,
                    dap_ui = true,
                    which_key = true,
                },
            })
        end,
    },
    {
        "echasnovski/mini.icons",
        opts = {},
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

    -- file explorer	
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        init = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            vim.opt.termguicolors = true
        end,
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                popup_border_style = "rounded",
                window = {
                    position = "float",
                },
                filesystem = {
                    hijack_netrw_behavior = "open_default",
                },
            })
        end,
    },
    -- keybind helper
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },

    -- package manager
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ensure_installed = {
                    "black",
                    "codespell",
                },
            })
        end,
    },

    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup({
                signcolumn = true,
                numhl = true,
                linehl = false,
                word_diff = false,
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text_pos = 'eol',
                    delay = 300,
                }
            })
        end,
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            vim.opt.termguicolors = true
            local bufferline = require("bufferline")
            bufferline.setup({
                highlights = require("catppuccin.groups.integrations.bufferline").get(),
                options = {
                    indicator = { style = "underline" },
                    style_preset = bufferline.style_preset.minimal,
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
                    end,
                }
            })
        end,
    },
    -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                },
            })
        end,
    },

    require("completion"),
    require("lsp"),
    require("debugging"),
    require("cmake"),
})
