local smart_contiue = function()
    local dap = require("dap")
    if dap.session() == nil then
        vim.cmd("CMakeDebug")
    else
        dap.continue()
    end
end

local register_keys = function()
    local wk = require("which-key")
    wk.add({
        { "<leader>c",  group = "cmake" },
        { "<leader>cb", "<cmd>CMakeBuild<CR>",    desc = "build" },
        { "<leader>cg", "<cmd>CMakeGenerate<CR>", desc = "generate" },
        {
            "<leader>cc",
            function()
                local build_dir = require("cmake-tools").get_build_directory().filename
                vim.cmd("FloatermNew ccmake " .. build_dir)
            end,
            desc = "open cache gui"
        },
        { "<leader>cs",  group = "select" },
        { "<leader>csb", "<cmd>CMakeSelectBuildTarget<cr>",  desc = "build target" },
        { "<leader>csl", "<cmd>CMakeSelectLaunchTarget<cr>", desc = "launch target" },

        { "<F5>",        smart_contiue,                      desc = "launch or continue" },
        { "<S-F5>",      "<cmd>CMakeRun<CR>",                desc = "run without debugging" },
    })
end

return {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cond = function()
        local search_results = vim.fs.find("CMakeLists.txt", {
            upward = true,
            stop = vim.uv.os_homedir(),
            path = vim.uv.cwd(),
        })
        return (#search_results ~= 0)
    end,
    config = function()
        require("cmake-tools").setup({
            cmake_build_directory = "cmake-build-${variant:buildType}",
            cmake_soft_link_compile_commands = true,
            cmake_compile_commands_from_lsp = true,
            cmake_dap_configuration = {
                name = "cpp",
                type = "codelldb",
                setupCommands = {
                    {
                        text = '-enable-pretty-printing',
                        description = 'enable pretty printing',
                        ignoreFailures = false
                    },
                },
            },
        })

        register_keys()
    end,
}
