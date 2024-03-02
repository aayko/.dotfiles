require("treesitter-context").disable()

local buf = vim.api.nvim_get_current_buf()
vim.api.nvim_buf_set_option(buf, 'tabstop', 2)
vim.api.nvim_buf_set_option(buf, 'softtabstop', 2)
vim.api.nvim_buf_set_option(buf, 'shiftwidth', 2)

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.nix",
    command = "lua vim.lsp.buf.format()",
})
