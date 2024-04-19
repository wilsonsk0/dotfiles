local wk = require("which-key")
local tree = require("nvim-tree.api").tree
local telescope_builtin = require("telescope.builtin")

wk.register({
    e = {
        name = "explorer",
        t = { tree.toggle, "toggle explorer" },
        e = { tree.open, "focus on explorer" },
    },
    f = {
        name = "files",
        f = { telescope_builtin.find_files, "find file" },
        g = { telescope_builtin.live_grep, "live grep" },
        b = { telescope_builtin.buffers, "find buffer" },
        h = { telescope_builtin.help_tags, "help tags" },
    },
    g = { "<cmd>FloatermNew --name=git lazygit<CR>", "git" }
}, { prefix = "<leader>" })


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        wk.register({
            n = {
                name = "navigate to",
                c = { vim.lsp.buf.declaration, "declaration" },
                d = { vim.lsp.buf.defintion, "definition" },
                i = { vim.lsp.buf.implementation, "implementation" },
                r = { vim.lsp.buf.references, "references" },
                t = { vim.lsp.buf.type_definition, "type definition" },
            },
            w = {
                name = "workspace",
                a = { vim.lsp.buf.add_workspace_folder, "add workspace folder" },
                d = { vim.lsp.buf.remove_workspace_folder, "remove workspace folder" },
                l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "list workspace folders" },
            },
        }, { prefix = "<leader>", buffer = ev.buf })

        wk.register({
            l = {
                name = "language",
                a = { vim.lsp.buf.code_action, "code action" },
                h = { vim.lsp.buf.hover, "hover" },
                k = { vim.lsp.buf.signature_help, "signature help" },
                f = { function() vim.lsp.buf.format({ async = true }) end, "format" },
                n = { vim.lsp.buf.rename, "rename" },
            },
        }, { mode = { "n", "v" }, prefix = "<leader>", buffer = ev.buf })
    end,
})


vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

