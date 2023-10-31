-- Allow comments in json files
vim.cmd([[ autocmd BufNewFile,BufRead *.json setlocal filetype=jsonc ]])

-- Remove new line comments behaviour on every file
vim.cmd([[ autocmd BufNewFile,BufRead * setlocal formatoptions-=cro ]])
