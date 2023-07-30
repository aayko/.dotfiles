return {
    {
        'ellisonleao/gruvbox.nvim',
    },
    {
        'folke/tokyonight.nvim',
    },
    {
        'catppuccin/nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                end,
            })
            require("catppuccin").setup {
                transparent_background = true,
                show_end_of_buffer = true,
            }
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.cmd("colorscheme catppuccin-macchiato")
        end,
    },
    -- {
    --     'zaldih/themery.nvim',
    --     opts = function()
    --         return {
    --             themes = {
    --                 "gruvbox",
    --                 "catppuccin-mocha",
    --                 "catppuccin-macchiato",
    --                 "tokyonight",
    --             },
    --             themeConfigFile = "~/.config/nvim/lua/settings/themery.lua",
    --             livePreview = true,
    --         },
    --         require('settings.themery')
    --     end,
    -- },
}
