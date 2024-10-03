return {
    'tpope/vim-fugitive',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup({
                signcolumn = true,
                numhl = true,
                linehl = false,
                word_diff = false,
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text_pos = 'eol',
                    delay = 300,
                }
            })
        end,
    },
}
