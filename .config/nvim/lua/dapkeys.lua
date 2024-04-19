local dap = require("dap")

vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
vim.keymap.set("n", "<F5>", dap.continue)

vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<S-F11>", dap.step_out)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<S-F10>", dap.step_back)

