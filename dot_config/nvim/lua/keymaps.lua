-- Search/Replace pattern for word below cursor
vim.keymap.set("n", "<leader>r", [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = false })

vim.keymap.set("n", "<leader>u", vim.cmd.MundoToggle)

-- Don't leave visual after indent
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Remap U to redo
vim.keymap.set("n", "<S-u>", "<C-r>")

-- ! for shell command
vim.keymap.set("n", "!", ":!", { silent = false })

-- Unbind space outside of insert
vim.keymap.set({ 'n', 'v' }, '<space>', '<nop>')

vim.keymap.set({ "n", "x" }, "s", "V")

vim.keymap.set({ "n", "x" }, "H", "^")
vim.keymap.set({ "n", "x" }, "L", "$")

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
-- Center on first search
vim.cmd("cnoremap <silent><expr> <enter> index(['/', '?'], getcmdtype()) >= 0 ? '<enter>zz' : '<enter>'")

-- Fix alpha.nvim <C-o> behavior
vim.keymap.set('n', '<C-o>', function()
    if vim.bo.filetype == 'alpha' then
        -- Send <C-o> twice
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-o><C-o>', true, true, true), 'n', true)
    else
        -- Send <C-o> once
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-o>', true, true, true), 'n', true)
    end
end)

-- Move lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Paste without losing clipboard
vim.keymap.set("x", "<leader>c", "\"_dP")

vim.keymap.set("n", "c", "\"_c")
vim.keymap.set("n", "C", "\"_C")

-- Makes the file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Alternate file
vim.keymap.set({ "n", "x" }, "<Tab>", "<CMD>b#<CR>zz")

-- Toggle virtual text
vim.keymap.set("n", "<leader>d", vim.cmd.DiagnosticsToggleVirtualText)

-- Swap semicolon colon
vim.keymap.set({ "n", "x" }, ";", ":")
vim.keymap.set({ "n", "x" }, ":", ";")
vim.keymap.set("n", "q;", "q:")

-- Indent on paste
vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

-- Indent whole file
vim.keymap.set("n", "<leader>=", "mzgg=G`zzz")

-- Toggle statusline
vim.keymap.set("n", "<C-g>", function()
    if vim.o.laststatus == 0 then
        vim.o.laststatus = 2
        vim.cmd('set statusline="%F %m%=%l,%c"')
    else
        vim.o.laststatus = 0
        vim.cmd("set statusline=%{repeat('─',winwidth('.'))}")
    end
end)

-- fzf cd to directories with a max depth of 1
function fzf_cd(directories, prompt)
    coroutine.wrap(function()
        local dirs = {}
        for _, directory in ipairs(directories) do
            local subdirs = vim.fn.globpath(directory, '*/', 0, 1)
            for _, subdir in ipairs(subdirs) do
                local relative_subdir = vim.fn.fnamemodify(subdir, ':~')
                table.insert(dirs, relative_subdir)
            end
        end
        local choice = require('fzf-lua').fzf(dirs, { prompt = prompt })
        if choice[1] ~= "esc" then
            vim.api.nvim_set_current_dir(choice[2])
        end
    end)()
end

vim.keymap.set('n', '<leader>po', ':lua fzf_cd({ "~/uni", "~/perso" }, "Projects> ")<CR>',
    { noremap = true, silent = true })
vim.keymap.set('n', '<leader>pc', ':lua fzf_cd({ "~/.config" }, "Config> ")<CR>', { noremap = true, silent = true })

vim.keymap.set({ 'n', 'x' }, 'go', ':silent !xdg-open <cfile> &<CR>')
