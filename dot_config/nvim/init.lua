vim.g.mapleader = ' '
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.tabstop = 8
vim.o.softtabstop = 0
vim.o.number = true


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("plugins")
require("lsp")
require("customkeys")

-- catpuccin
-- kanagawa
vim.cmd.colorscheme "tokyonight-storm"
