local wk = require("which-key")

local show_frames = function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames)
end
local show_locals = function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
end

wk.add({
    { "<leader>g",  "<cmd>FloatermNew --name=git lazygit<CR>",                                                   desc = "git" },

    { "<leader>f",  group = "find" },
    { "<leader>ff", function() require("telescope.builtin").find_files() end,                                    desc = "find file" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end,                                     desc = "live grep" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end,                                       desc = "find buffer" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end,                                     desc = "help tags" },

    { "<leader>t",  group = "tree" },
    { "<leader>tf", "<cmd>Neotree float<CR>",                                                                    desc = "files" },
    { "<leader>tg", "<cmd>Neotree float git_status<CR>",                                                         desc = "git_status" },
    { "<leader>tb", "<cmd>Neotree float buffers<CR>",                                                            desc = "buffers" },

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

    { "<Tab>",      "<cmd>bn<cr>",                                                                               desc = "next buffer" },
    { "<S-Tab>",    "<cmd>bp<cr>",                                                                               desc = "prev buffer" },
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
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
        })
    end,
})

vim.cmd([[
    " Expand
    imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
    smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

    " Expand or jump
    imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
    smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

    " Jump forward or backward
    imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
    smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

    " Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
    " See https://github.com/hrsh7th/vim-vsnip/pull/50
    nmap        s   <Plug>(vsnip-select-text)
    xmap        s   <Plug>(vsnip-select-text)
    nmap        S   <Plug>(vsnip-cut-text)
    xmap        S   <Plug>(vsnip-cut-text)
]])
