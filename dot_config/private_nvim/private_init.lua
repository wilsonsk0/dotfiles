vim.g.mapleader = ' '
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.number = true
vim.g.vsnip_snippet_dir = vim.fn.stdpath("data") .. "/snippets"

require("plugins")

vim.cmd.colorscheme "tokyonight"
