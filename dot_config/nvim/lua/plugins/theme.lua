return {
    {
        "jesseleite/nvim-noirbuddy",
        dependencies = {
            "tjdevries/colorbuddy.nvim",
            branch = "dev",
        },
        config = function ()
            require("noirbuddy").setup()
            vim.cmd("colorscheme noirbuddy")
        end
    },
    {
        'nikolvs/vim-sunbather',
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function ()
            vim.cmd([[
                colorscheme sunbather
            ]])
        end
    },
}
