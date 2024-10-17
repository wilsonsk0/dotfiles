require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        config = function(opts)
            require("nvim-treesitter.configs").setup(opts)
            vim.cmd [[TSUpdate]]
        end,
    },

    require("wilsonsk.telescope"),
    require("wilsonsk.lazydev"),
    require("wilsonsk.trouble"),

    require("appearance"),
    require("git"),

    -- package manager
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "black",
                "codespell",
                "glslls",
                "cmakelint",
            },
        },
    },

    { 'voldikss/vim-floaterm' },

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
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        opts = {},
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
                enable_cursor_hijack = true,
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

    require("textobjects"),
    require("completion"),
    require("lsp"),
    require("debugging"),
    require("cmake"),

    require("keymap"),
})
