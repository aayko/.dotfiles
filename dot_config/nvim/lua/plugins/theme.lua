return {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    enabled = true,
    config = true,
    init = function()
        vim.cmd("colorscheme gruvbox")
    end,
    opts = {
        overrides = {
            CursorLine = { bg = "#1d2021" },
            LineNrBelow = { fg = "#665c54" },
            LineNrAbove = { fg = "#665c54" },
            LineNr = { fg = "#ebdbb2" },
        },
        palette_overrides = {
            dark0 = "#0f0f0f",
            dark1 = "#0f0f0f",
        },
        bold = true,
        underline = true,
        italic = {
            strings = false,
            emphasis = false,
            comments = true,
            operators = false,
            folds = false,
        },
        transparent_mode = false,
    }
}
