vim.g.mapleader = ' '
vim.o.tabstop = 4
vim.o.softabstop = -1
vim.o.shiftwidth = 0
vim.o.expandtab = true
vim.g.vsnip_snippet_dir = vim.fn.stdpath("data") .. "/snippets"

-- setup folke/lazy.nvim
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
require("keymap")

vim.cmd.colorscheme "catppuccin-macchiato"


