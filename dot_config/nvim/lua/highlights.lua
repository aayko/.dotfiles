-- indentation character color
vim.api.nvim_set_hl(0, "@ibl.indent.char.1", { fg = "#23211e" })

-- current identation color
vim.api.nvim_set_hl(0, "@ibl.scope.char.1", { fg = "#3e3933" })

-- change visual color
vim.api.nvim_set_hl(0, "Visual", { bg = "#2e2d2c" })

-- cleaner window separator
vim.api.nvim_set_hl(0, "WinSeparator", { link = "@ibl.whitespace.char.1" })
vim.api.nvim_set_hl(0, "StatusLine", { link = "WinSeparator" })
vim.api.nvim_set_hl(0, "StatusLineNC", { link = "WinSeparator" })

-- grey fzf border
vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "@ibl.whitespace.char.1" })

-- orange yank color
vim.api.nvim_set_hl(0, "YankyYanked", { link = "IncSearch" })

-- grey lsp info border
vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "@ibl.whitespace.char.1" })

vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { link = "GruvboxGreen" })

vim.api.nvim_set_hl(0, "@operator", { link = "GruvboxAqua" })
vim.api.nvim_set_hl(0, "@punctuation.delimiter", { link = "GruvboxAqua" })
vim.api.nvim_set_hl(0, "@punctuation.delimiter", { link = "GruvboxAqua" })
vim.api.nvim_set_hl(0, "@lsp.typemod.punctuation.delimiter", { link = "GruvboxAqua" })
vim.api.nvim_set_hl(0, "@string.special.path", { link = "GruvboxGreen" })
vim.api.nvim_set_hl(0, "@lsp.type.property.nix", { link = "GruvboxYellow" })
vim.api.nvim_set_hl(0, "@string.special.url", { link = "GruvboxGreenUnderline" })

-- html
vim.api.nvim_set_hl(0, "@tag", { link = "GruvboxAquaBold" })
vim.api.nvim_set_hl(0, "@tag.delimiter", { link = "Comment" })
vim.api.nvim_set_hl(0, "@tag.attribute", { link = "GruvboxYellow" })
vim.api.nvim_set_hl(0, "@markup.heading", { link = "GruvboxFg0" })
vim.api.nvim_set_hl(0, "@constant", { link = "GruvboxAquaBold" })
vim.api.nvim_set_hl(0, "@none.html", { link = "GruvboxFg0" })
