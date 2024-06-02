local pick_build_target = function(opts)
    local cmake_tools = require("cmake-tools")
    local targets = cmake_tools.get_build_targets().data.targets
    local display_targets = cmake_tools.get_build_targets().data.display_targets

    require("telescope.pickers").new(opts, {
        prompt_title = "Select Build Target",
        finder = require("telescope.finders").new_table {
            results = display_targets,
            entry_maker = function(line)
                return require("telescope.make_entry").set_default_entry_mt({
                    ordinal = line,
                    display = line,
                    filename = "",
                }, opts)
            end,
        },
        previewer = nil,
        sorter = require("telescope.config").values.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr)
            local actions = require("telescope.actions")
            actions.select_default:replace(function()
                local action_state = require("telescope.actions.state")
                local selection = action_state.get_selected_entry()

                actions.close(prompt_bufnr)

                local config = require("cmake-tools.config")
                config.build_target = targets[selection.index]
            end)
            return true
        end,
    }):find()
end

local pick_launch_target = function(opts)
    local cmake_tools = require("cmake-tools")
    local targets = cmake_tools.get_launch_targets().data.targets

    require("telescope.pickers").new(opts, {
        prompt_title = "Select Launch Target",
        finder = require("telescope.finders").new_table {
            results = targets,
            entry_maker = function(line)
                return require("telescope.make_entry").set_default_entry_mt({
                    ordinal = line,
                    display = line,
                    filename = "",
                }, opts)
            end,
        },
        previewer = nil,
        sorter = require("telescope.config").values.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr)
            local actions = require("telescope.actions")
            actions.select_default:replace(function()
                local action_state = require("telescope.actions.state")
                local selection = action_state.get_selected_entry()

                actions.close(prompt_bufnr)

                local config = require("cmake-tools.config")
                config.launch_target = selection.display
            end)
            return true
        end,
    }):find()
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
            cmake_soft_link_compile_commands = false,
            cmake_compile_commands_from_lsp = true,
            cmake_dap_configuration = {
                name = "cpp",
                type = "cppdbg",
            },
        })

        -- set cmake related key binds here in case cmake is not loaded
        local wk = require("which-key")
        wk.register({
            c = {
                name = "cmake",
                s = {
                    name = "select",
                    b = { pick_build_target, "build target" },
                    l = { pick_launch_target, "launch target" },
                },
                b = { "<cmd>CMakeBuild<CR>", "build" },
                g = { "<cmd>CMakeGenerate<CR>", "generate" },
                c = { function()
                    local build_dir = require("cmake-tools.config").build_directory.filename
                    vim.cmd("FloatermNew ccmake " .. build_dir)
                end, "open cache gui" },
            },
        }, { prefix = "<leader>" })
        wk.register({
            ["<F5>"] = {
                function()
                    local dap = require("dap")
                    if dap.session() == nil then
                        vim.cmd("CMakeDebug")
                    else
                        dap.continue()
                    end
                end,
                "launch or continue"
            },
            ["<S-F5>"] = { "<cmd>CMakeRun<CR>", "run without debugging" },
        }, {})
    end
}
