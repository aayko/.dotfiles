return {
    {
        'ellisonleao/gruvbox.nvim',
    },
    {
        'folke/tokyonight.nvim',
    },
    {
        'catppuccin/nvim',
        config = function()
            require("catppuccin").setup {
                styles = {
                    comments = {"italic"},
                },
                show_end_of_buffer = true,
            }
        end,
    },
    {
        'zaldih/themery.nvim',
        opts = function()
            return {
                themes = {
                    "gruvbox",
                    "catppuccin-mocha",
                    "catppuccin-macchiato",
                    "tokyonight",
                },
                themeConfigFile = "~/.config/nvim/lua/settings/themery.lua",
                livePreview = true,
            },
            require('settings.themery')
        end,
    },
}
