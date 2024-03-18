-- orange indent gutter
vim.api.nvim_set_hl(0, "@ibl.scope.char.1", { fg = "#fe8019" })

-- change visual color
vim.api.nvim_set_hl(0, "Visual", { bg = "#3c3836" })

-- cleaner window separator
vim.api.nvim_set_hl(0, "WinSeparator", { link = "@ibl.whitespace.char.1" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#0f0f0f", fg = "#928374" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#0f0f0f", fg = "#928374" })

-- grey fzf border
vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "@ibl.whitespace.char.1" })

-- orange yank color
vim.api.nvim_set_hl(0, "YankyYanked", { link = "IncSearch" })
