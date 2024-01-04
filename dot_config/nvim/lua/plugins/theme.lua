return {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = true,
    opts = {
        overrides = {
            CursorLine = { bg = "#1d2021" },
        },
        palette_overrides = {
            dark0 = "#0f0f0f",
            dark1 = "#0f0f0f",
        },
        italic = {
            strings = false,
            emphasis = false,
            comments = false,
            operators = false,
            folds = false,
        },
        transparent_mode = false,
    },
}
