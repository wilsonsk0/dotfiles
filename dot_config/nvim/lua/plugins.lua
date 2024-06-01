require("lazy").setup({
    { "folke/neodev.nvim", opts = {} },
    {
    'nvim-telescope/telescope.nvim', tage = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- theme
    {
        "catppuccin/nvim",
        name = "catpuccin",
        lazy = false,
        priority = 1000,
    },

    -- file explorer	
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim",     -- Optional image support in preview window: See `# Preview Mode` for more information
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
        config = function() require("mason").setup() end,
    },

    --    {
    --        'voldikss/vim-floaterm'
    --    },

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

    require("completion"),
    require("lsp"),
    require("debugging"),
    require("cmake"),
})
