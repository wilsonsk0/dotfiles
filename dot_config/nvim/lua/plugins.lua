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

    {
        "elihunter173/dirbuf.nvim",
        opts = {
            hash_padding = 2,
            show_hidden = true,
            sort_order = "default",
            write_cmd = "DirbufSync",
        },
    },


    require("textobjects"),
    require("completion"),
    require("lsp"),
    require("debugging"),
    require("cmake"),

    require("keymap"),
})
