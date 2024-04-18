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
            require("nvim-tree").setup({
                view = {
                    preserve_window_proportions = true,
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
                    "cmake",
                    "lua_ls",
                    "rust_analyzer",
                },
            })
        end,
    },
    -- debugger
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "cpptools",
                },
                handlers = {},
            })
        end,
    },
    {
        "mfussenegger/nvim-dap",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
            dap.listeners.before.attach.dapui_config = dapui.open
            dap.listeners.before.launch.dapui_config = dapui.open
            dap.listeners.before.event_terminated.dapui_config = dapui.close
            dap.listeners.before.event_exited.dapui_config = dapui.close
        end
    },

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
    {
        'voldikss/vim-floaterm'
    },
    {
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, types = true },
            })
        end,
    },
    {
        "Civitasv/cmake-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("cmake-tools").setup({
                cmake_build_options = { "-j18" },
                cmake_build_directory = "cmake-build-${variant:buildType}",
                cmake_dap_configuration = {
                    name = "cpp",
                    type = "cppdbg"
                },
            })
        end,
        event = { "BufReadPre *.cpp", "BufNewFile *.cpp", "BufReadPre CMakeLists.txt", "BufNewFile CMakeLists.txt" },
    }
})
