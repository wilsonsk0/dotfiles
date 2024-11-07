vim.g.mapleader = ' '
vim.o.tabstop = 4
-- vim.o.softabstop = -1
vim.o.shiftwidth = 0
vim.o.expandtab = true
vim.o.number = true
vim.g.vsnip_snippet_dir = vim.fn.stdpath("data") .. "/snippets"

require("plugins")

vim.cmd.colorscheme "tokyonight"

