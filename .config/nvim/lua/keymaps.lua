local keymap = vim.keymap

-- Close window
keymap.set('n', '<leader>q',  '<CMD>q<CR>')

-- Close Buffer
keymap.set('n', '<leader>c',  '<CMD>bd<CR>')

-- Format file
keymap.set("n", "<leader>f=", vim.lsp.buf.format)
keymap.set("n", "<leader>=", "gg=G<C-o>", { noremap = true })

-- Search/Replace pattern for word below cursor
keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = false })

-- Better up/down
keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Move lines with alt+hjkl
keymap.set('n', '<A-j>', ':m .+1<CR>==')
keymap.set('n', '<A-k>', ':m .-2<CR>==')
keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv")
keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- New file
keymap.set("n", "<leader>fn", "<CMD>enew<cr>", { desc = "New File" })

-- Save file
keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<CMD>update<cr><esc>", { desc = "Save file" })

-- Better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Unbind command history
keymap.set("n", "Q", "<nop>")
keymap.set("n", "q<CMD>", "<nop>")

-- New lines
keymap.set("n", '<Leader>o', 'o<Esc>0"_D')
keymap.set("n", '<Leader>O', 'O<Esc>0"_D')

-- Repeat last macro
keymap.set('n', ',', '@@')

-- Swap ^ and 0
keymap.set("n", "^", "0")
keymap.set("n", "0", "^")

-- Remap U to redo
keymap.set("n", "<S-u>", "<C-r>")

keymap.set("n", "!", ":!", { silent = false })

-- Toggle word wrap
keymap.set("n", "<leader>ww", "<CMD>set wrap!<CR>")

-- Unbind space outside of insert
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

-- Delete a word using Ctrl+Backspace
keymap.set("i", "<C-BS>", "<C-w>")
keymap.set("c", "<C-BS>", "<C-w>")
keymap.set("i", "<C-H>", "<C-w>")
keymap.set("c", "<C-H>", "<C-w>")

-- Go to start-of-line/end-of-line
keymap.set("n", "H", "0")
keymap.set("n", "L", "$")

-- Move to window using the movement keys
keymap.set("n", "<left>", "<C-w>h")
keymap.set("n", "<down>", "<C-w>j")
keymap.set("n", "<up>", "<C-w>k")
keymap.set("n", "<right>", "<C-w>l")

-- Center on movement
keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true })
keymap.set("n", "<C-f>", "<C-f>zz", { noremap = true })
keymap.set("n", "*", "*zz", { noremap = true })
keymap.set("n", "#", "#zz", { noremap = true })
keymap.set("n", "n", "nzz", { noremap = true })
keymap.set("n", "N", "Nzz", { noremap = true })
keymap.set("n", "G", "Gzz", { noremap = true })
keymap.set("n", "}", "}zz", { noremap = true })
keymap.set("n", "{", "{zz", { noremap = true })
keymap.set("n", "<C-o>", "<C-o>zz", { noremap = true })
keymap.set("n", "<C-i>", "<C-i>zz", { noremap = true })

-- Mapping for dd that doesn't yank an empty line into your default register:
keymap.set("n", "dd", function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end, { expr = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Themery
keymap.set("n", "<leader>th", "<CMD>Themery<CR>")

-- NvimTree
keymap.set('n', '<leader>e',  '<CMD>NvimTreeToggle<CR>')

-- Workspaces
keymap.set('n', '<leader>wa', '<CMD>WorkspacesAdd<CR>')
