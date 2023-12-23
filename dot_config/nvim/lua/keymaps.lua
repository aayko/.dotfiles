local keymap = vim.keymap

-- Search/Replace pattern for word below cursor
keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = false })

-- Easier movement on wrapped lines
keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Don't leave visual after indent
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Unbind command history
keymap.set("n", "q:", "<nop>")

-- Remap U to redo
keymap.set("n", "<S-u>", "<C-r>")

-- ! for shell command
keymap.set("n", "!", ":!", { silent = false })

-- Unbind space outside of insert
keymap.set({ 'n', 'v' }, '<space>', '<nop>')

keymap.set({ "n", "v" }, "s", "V")

keymap.set({ "n", "v" }, "H", "^")
keymap.set({ "n", "v" }, "L", "$")

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

-- NvimTree
keymap.set('n', '<leader>e', vim.cmd.NvimTreeToggle)

-- UndoTree
keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Move lines
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Paste without losing clipboard
keymap.set("x", "<leader>p", "\"_dP")

keymap.set("n", "c", "\"_c")
keymap.set("n", "C", "\"_C")

-- Makes the file executable
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Escape vim terminal
keymap.set("t", "<esc>", "<C-\\><C-n><C-w>h",{ silent = true })

-- Fugitive
keymap.set("n", "<leader>g", "<CMD>tab G<CR>")

-- Alternate file
keymap.set("n","<BS>", "<CMD>b#<CR>")

-- Toggle virtual text
keymap.set("n","<leader>d", "<CMD>DiagnosticsToggleVirtualText<CR>")

-- Swap semicolon colon
keymap.set({ "n", "v" },";", ":")
keymap.set({ "n", "v" },":", ";")
