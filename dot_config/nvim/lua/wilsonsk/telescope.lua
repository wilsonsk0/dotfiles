return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'nvim-telescope/telescope-ui-select.nvim'
    },

    config = function()
        local telescope = require('telescope')
        telescope.setup {
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown {}
                },
            },
        }

        telescope.load_extension('ui-select')
    end,
}
