-- Allow comments in json files
vim.cmd([[ autocmd BufNewFile,BufRead *.json setlocal filetype=jsonc ]])

-- Remove new line comments behaviour on every file
vim.cmd([[ autocmd BufNewFile,BufRead * setlocal formatoptions-=cro ]])

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.cmd([[ autocmd FileType tex autocmd BufWritePost <buffer> silent make ]])
vim.cmd([[ autocmd FileType php hi! link @Variable GruvboxBlue ]])
vim.cmd([[ autocmd VimEnter * if luaeval('require("oil").get_current_dir()') == '/home/ayko/.todo/' | call luaeval('require("oil").toggle_hidden()') | endif ]])
