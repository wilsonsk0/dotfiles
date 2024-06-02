return {
    "nvim-neotest/nvim-nio",
    {
        "mfussenegger/nvim-dap",
        config = function()
            local wk = require("which-key")
            wk.register({
                ['<F5>'] = { function() require("dap").continue() end, "continue" },
                ['<F6>'] = { function() require("dap").terminate() end, "terminate" },
                ['<F10>'] = { function() require("dap").step_over() end, "step over" },
                ['<F11>'] = { function() require("dap").step_into() end, "step into" },
                ['<F12>'] = { function() require("dap").step_out() end, "step out" },
            })

            wk.register({
                d = {
                    name = "debugging",
                    b = { function() require("dap").toggle_breakpoint() end, "toggle breakpoint" },
                    B = { function() require("dap").set_breakpoint() end, "set breakpoint" },
                    l = { function() require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, "set log point" },
                },
            }, { prefix = "<leader>" })

            local enable_active_debug_keys = function()
                wk.register({
                    ['dr'] = { function() require("dap").repl.open() end, "open repl" },
                    ['du'] = { function() require("dap").up() end, "go up one frame" },
                    ['dd'] = { function() require("dap").down() end, "go down one frame" },
                    ['df'] = {
                        function()
                            local widgets = require("dap.ui.widgets")
                            widgets.centered_float(widgets.frames)
                        end,
                        "frames"
                    },
                    ['ds'] = {
                        function()
                            local widgets = require("dap.ui.widgets")
                            widgets.centered_float(widgets.scopes)
                        end,
                        "locals"
                    },
                }, { prefix = "<leader>" })
                wk.register({
                    ["dp"] = { function() require("dap.ui.widgets").preview() end, "preview" },
                    ["dh"] = { function() require("dap.ui.widgets").hover() end, "hover" },
                    { prefix = "<leader>", mode = { "n", "v" } }
                })
            end

            local disable_active_debug_keys = function()
                wk.register({
                    ['dr'] = nil,
                    ['df'] = nil,
                    ['ds'] = nil,
                    ['du'] = nil,
                    ['dd'] = nil,
                }, { prefix = "<leader>" })
                wk.register({
                    ["dp"] = nil,
                    ["dh"] = nil,
                    { prefix = "<leader>", mode = { "n", "v" } }
                })
            end

            local dap = require("dap")
            dap.listeners.before.attach.keymap = enable_active_debug_keys
            dap.listeners.before.launch.keymap = enable_active_debug_keys
            dap.listeners.before.event_terminated.keymap = disable_active_debug_keys
            dap.listeners.before.event_exited.keymap = disable_active_debug_keys

            local flicker_neotree = function()
                vim.cmd("Neotree toggle")
                vim.cmd("Neotree toggle")
            end
            dap.listeners.before.event_terminated.neotree = flicker_neotree
            dap.listeners.before.event_exited.neotree = flicker_neotree
        end
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            require('mason-nvim-dap').setup({
                ensure_installed = { "cppdbg" },
                handlers = {}, -- sets up dap in the predefined manner
            })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end
    },
}
