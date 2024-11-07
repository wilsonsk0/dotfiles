return {
  {
    "nvim-neotest/nvim-nio",
    event = { 'BufNewFile', 'BufReadPre' },
  },
  {
    "mfussenegger/nvim-dap",
    event = { 'BufNewFile', 'BufReadPre' },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = { 'BufNewFile', 'BufReadPre' },
    opts = {
      ensure_installed = { "codelldb", "debugpy", "cppdbg" },
      handlers = {}, -- sets up dap in the predefined manner
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    event = { 'BufNewFile', 'BufReadPre' },
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

      dap.defaults.codelldb.exception_breakpoints = { "uncaught" }
    end
  },
}
