require("lazy").setup({
    -- themes
    {
        "catppuccin/nvim", name = "catpuccin", priority = 1000
    },
    {
        "rebelot/kanagawa.nvim",
        config = function()
            local theme = "dragon"
            require("kanagawa").setup({
                theme = theme,
                background = {
                    dark = theme,
                },
            })
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "baliestri/aura-theme",
        lazy = false,
        priority = 1000,
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
            vim.cmd([[colorscheme aura-dark]])
        end
    },
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
                    "clangd",
                    "lua_ls",
                    "rust_analyzer",
                },
            })
        end,
    },
    -- debugger
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "cppdbg",
                },
                handlers = {},
            })
        end,
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("dapkeys")
        end,
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
                library = { plugins = { "nvim-dap-ui", "cmake-tools.nvim" }, types = true },
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
                cmake_build_directory = "cmake-build-${variant:buildType}",
                cmake_soft_link_compile_commands = false,
                cmake_compile_commands_from_lsp = true,
                cmake_dap_configuration = {
                    name = "cpp",
                    type = "cppdbg"
                },
            })
            require("cmake")
        end,
        cond = function()
            local search_results = vim.fs.find("CMakeLists.txt", {
                upward = true,
                stop = vim.uv.os_homedir(),
                path = vim.uv.cwd(),
            })
            return (#search_results ~= 0)
        end,
        enabled = true,
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
    }
})
