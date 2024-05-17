local wk = require("which-key")
local tree = require("nvim-tree.api").tree
local telescope_builtin = require("telescope.builtin")

wk.register({
    e = {
        name = "explorer",
        t = { tree.toggle, "toggle explorer" },
        e = { tree.open, "focus on explorer" },
        s = { "<cmd>NvimTreeFindFile<CR>", "show file in tree" },
    },
    s = {
        name = "search",
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
            t = {
                name = "go to",
                D = { vim.lsp.buf.declaration, "declaration" },
                d = { vim.lsp.buf.definition, "definition" },
                i = { vim.lsp.buf.implementation, "implementation" },
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
            ["sr"] = { "<cmd>Trouble lsp_references toggle<cr>", "lsp references" },
            l = {
                name = "language",
                a = { vim.lsp.buf.code_action, "code action" },
                h = { vim.lsp.buf.hover, "hover" },
                k = { vim.lsp.buf.signature_help, "signature help" },
                f = { function() vim.lsp.buf.format({ async = true }) end, "format" },
                n = { vim.lsp.buf.rename, "rename" },
                s = { "<cmd>Trouble lsp_document_symbols toggle<CR>", "symbols" },
                p = { "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", "buffer problems" },
                P = { "<cmd>Trouble diagnostics toggle<CR>", "all problems" },
            },
        }, { mode = { "n", "v" }, prefix = "<leader>", buffer = ev.buf })
    end,
})
