vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.tex",
    command = "silent make"
})
