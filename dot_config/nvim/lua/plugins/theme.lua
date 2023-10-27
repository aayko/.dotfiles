return {
    {
        'ellisonleao/gruvbox.nvim',
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            require('gruvbox').setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = true,
                bold = true,
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = true,
            })
            vim.o.background = "dark"
            vim.cmd([[colorscheme gruvbox]])
        end
    },
    {
        'catppuccin/nvim',
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                    vim.api.nvim_set_hl(0, "WinSeparator", { bg = "None", fg= "#313244" })
                    -- vim.api.nvim_set_hl(0, "WinSeparator", { bg = "None", fg= "#222222" })
                    -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#b4befe" })
                    -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffffff" })
                    -- vim.api.nvim_set_hl(0, "TelescopeNormal", {bg="#000000"})
                    -- vim.api.nvim_set_hl(0, "TelescopeBorder", {bg="#000000"})
                    -- vim.api.nvim_set_hl(0, 'Normal', { bg = "#000000", fg = "#ffffff" })
                end,
            })
            require("catppuccin").setup {
                transparent_background = false,
                show_end_of_buffer = true,
                    color_overrides = {
                        mocha = {
                            blue = "#cccccc",
                            base = "#000000",
                            text = "#ffffff",
                            mantle = "#000000",
                            crust = "#000000",
                        },
                    },
            }
            -- vim.cmd("colorscheme catppuccin-mocha")
        end,
    },
}
