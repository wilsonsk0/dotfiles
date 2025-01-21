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
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
      require("refactoring").setup()
    end,
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
          "cppcheck",
          "black",
          "isort",
        },
        automatic_installation = false,
      })

      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.code_actions.refactoring,
          null_ls.builtins.diagnostics.codespell,
          null_ls.builtins.diagnostics.cppcheck,

          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.diagnostics.mypy,

        }
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { 'BufNewFile', 'BufReadPre' },
    dependencies = { "williamboman/mason-lspconfig.nvim" }
  },
  {
    'p00f/clangd_extensions.nvim',
    config = true,
    opts = {
      extensions = {
        inlay_hints = {
          only_current_line = false,
        },
      },
    },
  },
}
