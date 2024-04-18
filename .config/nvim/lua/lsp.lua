local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.rust_analyzer.setup({ capabilities = capabilities })
lspconfig.glsl_analyzer.setup({
    capabilities = capabilities,
    filetypes = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp" },
})
lspconfig.cmake.setup({ capabilities = capabilities })
lspconfig.ltex.setup({ capabilities = capabilities })

