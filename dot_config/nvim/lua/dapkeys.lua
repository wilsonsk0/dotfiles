local dap = require("dap")

vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F6>', dap.terminate)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)
vim.keymap.set('n', '<F12>', dap.step_out)

local wk = require("which-key")
wk.register({
    b = {
        name = "breakpoints",
        b = { dap.toggle_breakpoint, "toggle breakpoint" },
        B = { dap.set_breakpoint, "set breakpoint" },
        l = { function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, "set log point" },
    },
    d = {
        name = "debugging",
        r = { dap.repl.open, "open repl" },
        l = { dap.run_last, "run last configuration" },
        f = { function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.frames)
        end, "frames" },
        s = { function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.scopes)
        end, "locals" },
        u = { dap.up, "go up one frame" },
        d = { dap.down, "go down one frame"},
    },
}, { prefix = "<leader>" })

wk.register({
    ["<leader>dl"] = { require("dap.ui.widgets").preview, "preview" },
    ["<leader>dh"] = { require("dap.ui.widgets").hover, "hover" },
    { mode = { "n", "v" } }
})

