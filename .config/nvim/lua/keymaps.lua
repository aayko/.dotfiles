-- Close window
vim.keymap.set('n', '<leader>q',  '<CMD>q<CR>')

-- Close Buffer
vim.keymap.set('n', '<leader>c',  '<CMD>bd<CR>')

-- Format file
vim.keymap.set("n", "<leader>f=", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>=", "gg=G<C-o>", { noremap = true })

-- Search/Replace pattern for word below cursor
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = false })

-- Better up/down
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Move lines with alt+hjkl
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==')
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- New file
vim.keymap.set("n", "<leader>fn", "<CMD>enew<cr>", { desc = "New File" })

-- Save file
vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<CMD>update<cr><esc>", { desc = "Save file" })

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Unbind command history
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q<CMD>", "<nop>")

-- New lines
vim.keymap.set("n", '<Leader>o', 'o<Esc>0"_D')
vim.keymap.set("n", '<Leader>O', 'O<Esc>0"_D')

-- Repeat last macro
vim.keymap.set('n', ',', '@@')

-- Swap ^ and 0
vim.keymap.set("n", "^", "0")
vim.keymap.set("n", "0", "^")

-- Remap U to redo
vim.keymap.set("n", "<S-u>", "<C-r>")

vim.keymap.set("n", "!", ":!", { silent = false })

-- Toggle word wrap
vim.keymap.set("n", "<leader>ww", "<CMD>set wrap!<CR>")

-- Unbind space outside of insert
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

-- Move to window using the movement keys
vim.keymap.set("n", "<left>", "<C-w>h")
vim.keymap.set("n", "<down>", "<C-w>j")
vim.keymap.set("n", "<up>", "<C-w>k")
vim.keymap.set("n", "<right>", "<C-w>l")

-- Center on movement
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true })
vim.keymap.set("n", "<C-f>", "<C-f>zz", { noremap = true })
vim.keymap.set("n", "*", "*zz", { noremap = true })
vim.keymap.set("n", "#", "#zz", { noremap = true })
vim.keymap.set("n", "n", "nzz", { noremap = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true })
vim.keymap.set("n", "G", "Gzz", { noremap = true })
vim.keymap.set("n", "}", "}zz", { noremap = true })
vim.keymap.set("n", "{", "{zz", { noremap = true })
vim.keymap.set("n", "<C-o>", "<C-o>zz", { noremap = true })
vim.keymap.set("n", "<C-i>", "<C-i>zz", { noremap = true })

-- Themery
vim.keymap.set("n", "<leader>th", "<CMD>Themery<CR>")

-- NvimTree
vim.keymap.set('n', '<leader>e',  '<CMD>NvimTreeToggle<CR>')

-- Workspaces
vim.keymap.set('n', '<leader>wa', '<CMD>WorkspacesAdd<CR>')
