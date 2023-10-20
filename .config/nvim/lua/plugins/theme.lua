return {
    {
        'ellisonleao/gruvbox.nvim',
        enabled = false,
    },
    {
        'catppuccin/nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                    vim.api.nvim_set_hl(0, "WinSeparator", { bg = "None", fg= "#313244" })
                    vim.api.nvim_set_hl(0, "LineNr", { fg= "#b4befe" })
                end,
            })
            require("catppuccin").setup {
                transparent_background = false,
                show_end_of_buffer = true,
            }
            vim.cmd("colorscheme catppuccin-mocha")
        end,
    },
}
