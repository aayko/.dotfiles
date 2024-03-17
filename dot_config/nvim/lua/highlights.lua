-- orange indent gutter
vim.api.nvim_set_hl(0, "@ibl.scope.char.1", { fg = "#fe8019" })

-- change visual color
vim.api.nvim_set_hl(0, "Visual", { bg = "#3c3836" })

-- cleaner window separator
vim.api.nvim_set_hl(0, "WinSeparator", { link = "@ibl.whitespace.char.1" })
vim.api.nvim_set_hl(0, "StatusLine", { link = "WinSeparator" })
vim.api.nvim_set_hl(0, "StatusLineNC", { link = "WinSeparator" })

-- grey fzf border
vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "@ibl.whitespace.char.1" })

-- orange yank color
vim.api.nvim_set_hl(0, "YankyYanked", { link = "IncSearch" })
