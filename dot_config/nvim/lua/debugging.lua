return {
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap",
    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            require('mason-nvim-dap').setup({
                ensure_installed = { 'stylua', 'jq' },
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
