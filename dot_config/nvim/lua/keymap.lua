local wk = require("which-key")

wk.register({
    g = { "<cmd>FloatermNew --name=git lazygit<CR>", "git" },
    f = {
        name = "find",
        f = { function() require("telescope.builtin").find_files() end, "find file" },
        g = { function() require("telescope.builtin").live_grep() end, "live grep" },
        b = { function() require("telescope.builtin").buffers() end, "find buffer" },
        h = { function() require("telescope.builtin").help_tags() end, "help tags" },
    },
    t = {
        name = "tree",
        f = { "<cmd>Neotree focus<CR>", "focus" },
        c = { "<cmd>Neotree close<CR>", "close" },
    },
}, { prefix = "<leader>" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        wk.register({
            l = {
                name = "lsp",
                a = { vim.lsp.buf.code_action, "code action" },
                d = { vim.lsp.buf.definition, "definition" },
                D = { vim.lsp.buf.declaration, "declaration" },
                i = { vim.lsp.buf.implementation, "implementation" },
                f = { vim.lsp.buf.format, "format" },
                h = { vim.lsp.buf.hover, "hover" },
                c = { vim.lsp.buf.incoming_calls, "incoming calls" },
                C = { vim.lsp.buf.outgoing_calls, "outgoing calls" },
                R = { vim.lsp.buf.references, "references" },
                r = { vim.lsp.buf.rename, "rename" },
            }
        }, { mode = { "n", "v" }, prefix = "<leader>", buffer = ev.buf })
    end,
})

wk.register({
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
