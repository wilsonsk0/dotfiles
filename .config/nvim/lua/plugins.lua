require("lazy").setup({
    -- file explorer	
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        init = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            vim.opt.termguicolors = true
        end,
        config = function()
            require("nvim-tree").setup()
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
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        init = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "lua_ls",
                    "rust_analyzer",
                },
            })
        end,
    },
    --	"mfussenegger/nvim-dap",
    --	{
    --		"rcarriga/nvim-dap-ui",
    --		dependencies = {
    --			"mfussenegger/nvim-dap",
    --			"nvim-neotest/nvim-nio"
    --		}
    --	},
    --	{
    --		"folke/neodev.nvim",
    --		config = function()
    --			require("neodev").setup({
    --				library = { plugins = {"nvim-dap-ui"}, types = true},
    --			})
    --		end,
    --	},

    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
    },

    -- code completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('completion')
        end,
    },

    -- theme
    {
        "catppuccin/nvim", name = "catpuccin", priority = 1000
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
})
