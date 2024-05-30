local dap = require("dap")

vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F6>', dap.terminate)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)
vim.keymap.set('n', '<F12>', dap.step_out)

local wk = require("which-key")

wk.register({
    d = {
        name = "debugging",
        b = { dap.toggle_breakpoint, "toggle breakpoint" },
        B = { dap.set_breakpoint, "set breakpoint" },
        l = { function()
            dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
        end, "set log point" },
    },
}, { prefix = "<leader>" })

local enable_active_debug_keys = function()
    wk.register({
        ['dr'] = { dap.repl.open, "open repl" },
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
        ['du'] = { dap.up, "go up one frame" },
        ['dd'] = { dap.down, "go down one frame" },
    }, { prefix = "<leader>" })
    wk.register({
        ["dp"] = { require("dap.ui.widgets").preview, "preview" },
        ["dh"] = { require("dap.ui.widgets").hover, "hover" },
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

dap.listeners.before.attach.keymap = enable_active_debug_keys
dap.listeners.before.launch.keymap = enable_active_debug_keys
dap.listeners.before.event_terminated.keymap = disable_active_debug_keys
dap.listeners.before.event_exited.keymap = disable_active_debug_keys

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/local/bin/lldb-vscode',
    name = 'lldb',
}

