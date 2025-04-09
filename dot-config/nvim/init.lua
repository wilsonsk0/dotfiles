vim.opt.tabstop = 4        -- Set the width of a tab to 4 spaces
vim.opt.shiftwidth = 4     -- Number of spaces for auto-indent
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.softtabstop = 4    -- Insert 4 spaces when pressing Tab

require("config.lazy")

vim.cmd[[colorscheme tokyonight]]
