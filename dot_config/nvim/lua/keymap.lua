-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local wk = require("which-key")

        -- don't register keys for null-ls
        local client_id = ev.data.client_id
        local client_name = vim.lsp.get_client_by_id(client_id).name
        if (client_name == "null-ls") then
            return
        end

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        wk.add({
            mode = { "n", "v" },
            buffer = ev.buf,
            { "<leader>l",  group = "lsp" },
            { "<leader>la", function() vim.lsp.buf.code_action() end,    desc = "code action" },
            { "<leader>ld", function() vim.lsp.buf.definition() end,     desc = "definition" },
            { "<leader>lD", function() vim.lsp.buf.declaration() end,    desc = "declaration" },
            { "<leader>li", function() vim.lsp.buf.implementation() end, desc = "implementation" },
            { "<leader>lf", function() vim.lsp.buf.format() end,         desc = "format" },
            { "<leader>lh", function() vim.lsp.buf.hover() end,          desc = "hover" },
            { "<leader>lc", function() vim.lsp.buf.incoming_calls() end, desc = "incoming calls" },
            { "<leader>lC", function() vim.lsp.buf.outgoing_calls() end, desc = "outgoing calls" },
            { "<leader>lR", function() vim.lsp.buf.references() end,     desc = "references" },
            { "<leader>lr", function() vim.lsp.buf.rename() end,         desc = "rename" },


            { "]m",         desc = "go to next function start" },
            { "]M",         desc = "go to next function end" },
            { "]]",         desc = "go to next class start" },
            { "][",         desc = "go to next class end" },
            { "]o",         desc = "go to next loop" },
            { "]s",         desc = "go to next scope" },
            { "[m",         desc = "go to prev function start" },
            { "[M",         desc = "go to prev function end" },
            { "[[",         desc = "go to prev class start" },
            { "[]",         desc = "go to prev class end" },
            { "<leader>lp", desc = "peek function definition" },
            { "<leader>lP", desc = "peek class definition" },
            { "ys",         group = "insert surround" },
            { "ds",         group = "delete surround" },
            { "cs",         group = "change surround" },
        })
    end,
})

vim.api.nvim_set_keymap('i', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"',
    { expr = true, noremap = false })
vim.api.nvim_set_keymap('s', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"',
    { expr = true, noremap = false })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"',
    { expr = true, noremap = false })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"',
    { expr = true, noremap = false })

local show_frames = function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames)
end
local show_locals = function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
end

-- keybind helper
return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            spec = {
                { "<leader>f",  group = "find" },
                { "<leader>ff", function() require("telescope.builtin").find_files() end,                                    desc = "find file" },
                { "<leader>fg", function() require("telescope.builtin").live_grep() end,                                     desc = "live grep" },
                { "<leader>fb", function() require("telescope.builtin").buffers() end,                                       desc = "find buffer" },
                { "<leader>fh", function() require("telescope.builtin").help_tags() end,                                     desc = "help tags" },
                { "-", "<cmd>Oil<cr>", desc = "Open parent directory"},

                { "<F5>",       function() require("dap").continue() end,                                                    desc = "continue" },
                { "<F6>",       function() require("dap").terminate() end,                                                   desc = "terminate" },
                { "<F10>",      function() require("dap").step_over() end,                                                   desc = "step over" },
                { "<F11>",      function() require("dap").step_into() end,                                                   desc = "step into" },
                { "<F12>",      function() require("dap").step_out() end,                                                    desc = "step out" },

                { "<leader>d",  group = "debugging" },
                { "<leader>db", function() require("dap").toggle_breakpoint() end,                                           desc = "toggle breakpoint" },
                { "<leader>dB", function() require("dap").set_breakpoint() end,                                              desc = "set breakpoint" },
                { "<leader>dl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "set log point" },
                { "<leader>dr", function() require("dap").repl.open() end,                                                   desc = "open repl" },
                { "<leader>du", function() require("dap").up() end,                                                          desc = "go up one frame" },
                { "<leader>dd", function() require("dap").down() end,                                                        desc = "go down one frame" },
                { "<leader>df", show_frames,                                                                                 desc = "frames" },
                { "<leader>ds", show_locals,                                                                                 desc = "locals" },
            }
        },
    },
}
