return {
  {
    "williamboman/mason-lspconfig.nvim",
    event = { 'BufNewFile', 'BufReadPre' },
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "clangd",
        "lua_ls",
        "cmake",
        -- "pylsp",
        "pyright",
        "rust_analyzer",
      },
      automatic_installation = true,
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = require("cmp_nvim_lsp").default_capabilities()
          }
        end,
        ["clangd"] = function()
          require("lspconfig").clangd.setup {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            offset_encoding = 'utf-16',
          }
        end,
      }
    },
  },

  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "codespell",
        },
        automatic_installation = false,
      })
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.codespell,
          null_ls.builtins.diagnostics.cppcheck,
          null_ls.builtins.formatting.black,
        }
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { 'BufNewFile', 'BufReadPre' },
    dependencies = { "williamboman/mason-lspconfig.nvim" }
  },
}
