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

require("which-key").register({
    c = {
        name = "cmake",
        s = {
            name = "select",
            b = { pick_build_target, "build target" },
            l = { pick_launch_target, "launch target" },
        },
    },
}, { prefix = "<leader>" })

vim.keymap.set("n", "<F5>", "<cmd>CMakeDebug<CR>")
vim.keymap.set("n", "<C-F5>", "<cmd>CMakeRun<CR>")
