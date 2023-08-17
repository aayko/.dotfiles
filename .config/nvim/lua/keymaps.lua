local keymap = vim.keymap

-- Search/Replace pattern for word below cursor
keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = false })

-- Better up/down
keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Move lines with alt+hjkl
keymap.set('n', '<A-j>', ':m .+1<CR>==', { silent = true })
keymap.set('n', '<A-k>', ':m .-2<CR>==', { silent = true })
keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { silent = true })
keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { silent = true })
keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true })
keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true })

-- New file
keymap.set("n", "<leader>fn", vim.cmd.enew, { desc = "New File" })

-- Save file
keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<CMD>update<CR><ESC>", { desc = "Save file" })

-- Don't leave visual after indent
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Unbind command history
keymap.set("n", "Q", "<nop>")
keymap.set("n", "q<CMD>", "<nop>")

-- Repeat last macro
keymap.set('n', ',', '@@')

-- Remap U to redo
keymap.set("n", "<S-u>", "<C-r>")

-- ! for shell command
keymap.set("n", "!", ":!", { silent = false })

-- Toggle word wrap
keymap.set("n", "<leader>lw", "<CMD>set wrap!<CR>", { silent = true })

-- Unbind space outside of insert
keymap.set({ 'n', 'v' }, '<space>', '<nop>')

-- Delete a word using Ctrl+Backspace
keymap.set("i", "<C-BS>", "<C-w>")
keymap.set("c", "<C-BS>", "<C-w>")
keymap.set("i", "<C-H>", "<C-w>")
keymap.set("c", "<C-H>", "<C-w>")

-- Go to start-of-line/end-of-line
keymap.set({ "n", "v" }, "0", "^")
keymap.set({ "n", "v" }, "^", "0")

-- Move to window using the movement keys
keymap.set("n", "<left>", "<C-w>h")
keymap.set("n", "<down>", "<C-w>j")
keymap.set("n", "<up>", "<C-w>k")
keymap.set("n", "<right>", "<C-w>l")

keymap.set("n", "L", "$")
keymap.set("n", "H", "^")

keymap.set({ "n", "v" }, "s", "V")

keymap.set("n", "Q", "q")
keymap.set("n", "q", "@w")

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

-- Center on first search
vim.cmd("cnoremap <silent><expr> <enter> index(['/', '?'], getcmdtype()) >= 0 ? '<enter>zz' : '<enter>'")

keymap.set("n", "<C-Up>", "<CMD>resize +2<CR>", { desc = "Increase window height", silent = true })
keymap.set("n", "<C-Down>", "<CMD>resize -2<CR>", { desc = "Decrease window height", silent = true})
keymap.set("n", "<C-Left>", "<CMD>vertical resize -2<CR>", { desc = "Decrease window width", silent = true})
keymap.set("n", "<C-Right>", "<CMD>vertical resize +2<CR>", { desc = "Increase window width", silent = true})

-- Paste over while keeping register
keymap.set("v", "<leader>p", "\"_dP")

-- Themery
keymap.set("n", "<leader>th", "<CMD>Themery<CR>")

-- NvimTree
keymap.set('n', '<leader>e', vim.cmd.NvimTreeToggle)

-- UndoTree
keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Clear highlight
keymap.set('n', '<leader>n', '<CMD>noh<CR>')
