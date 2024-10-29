vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
  callback = function()
    vim.schedule(function()
      vim.cmd([[Trouble quickfix open]])       -- Open Trouble for quickfix
    end)
  end,
})

return {
  "folke/trouble.nvim",
  opts = {},   -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  event = { 'BufNewFile', 'BufReadPre' },
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
