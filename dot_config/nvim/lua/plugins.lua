-- setup folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

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
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            default_file_explorer = true,
            delete_to_trash = true,
            watch_for_changes = true,
            view_options = {
                show_hidden = true,
            }
        },
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        version = '*',
    },


    {
        "williamboman/mason.nvim",
        name = "mason",
        config = function()
            require("mason").setup()
        end
    },

    require("textobjects"),
    require("completion"),
    require("lsp"),
    require("debugging"),
    require("cmake"),

    require("keymap"),
})
