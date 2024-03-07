local map = vim.keymap.set

-- Search/Replace pattern for word below cursor
map("n", "<leader>r", [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = false })

map("n", "<leader>u", vim.cmd.MundoToggle)

-- Don't leave visual after indent
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Remap U to redo
map("n", "<S-u>", "<C-r>")

-- ! for shell command
map("n", "!", ":!", { silent = false })

-- Unbind space outside of insert
map({ 'n', 'v' }, '<space>', '<nop>')

map({ "n", "x" }, "s", "V")

map({ "n", "x" }, "H", "^")
map({ "n", "x" }, "L", "$")

-- Center on movement
map("n", "<C-d>", "<C-d>zz", { noremap = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true })
map("n", "<C-b>", "<C-b>zz", { noremap = true })
map("n", "<C-f>", "<C-f>zz", { noremap = true })
map("n", "*", "*zz", { noremap = true })
map("n", "#", "#zz", { noremap = true })
map("n", "n", "nzz", { noremap = true })
map("n", "N", "Nzz", { noremap = true })
map("n", "G", "Gzz", { noremap = true })
map("n", "}", "}zz", { noremap = true })
map("n", "{", "{zz", { noremap = true })
map("n", "<C-o>", "<C-o>zz", { noremap = true })
map("n", "<C-i>", "<C-i>zz", { noremap = true })
-- Center on first search
vim.cmd("cnoremap <silent><expr> <enter> index(['/', '?'], getcmdtype()) >= 0 ? '<enter>zz' : '<enter>'")

-- File explorer
map('n', '<C-y>', function()
    if vim.o.filetype == 'oil' then
        require('oil').close()
    else
        require('oil').open(vim.fn.getcwd())
    end
end)

-- Open pdf file under cursor in zathura while in oil.nvim
map('n', '<C-p>', function()
    if vim.o.filetype ~= 'oil' then return end
    local file_name = vim.fn.getline('.'):match('%s+(.+)$')

    if not file_name:match("%.pdf$") then return end

    local current_dir = require("oil").get_current_dir()
    local file_path = current_dir .. file_name
    local escaped_file_path = vim.fn.shellescape(file_path)

    local job_id = vim.fn.jobstart('zathura ' .. escaped_file_path, {
        detach = true,
    })
end)

-- Move lines
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Paste without losing clipboard
map("x", "<leader>c", "\"_dP")

map("n", "c", "\"_c")
map("n", "C", "\"_C")

-- Makes the file executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Fugitive
map("n", "<leader>g", "<CMD>tab G<CR>")

-- Alternate file
map({ "n", "x" }, "<Tab>", "<CMD>b#<CR>zz")

-- Toggle virtual text
map("n", "<leader>d", vim.cmd.DiagnosticsToggleVirtualText)

-- Swap semicolon colon
map({ "n", "x" }, ";", ":")
map({ "n", "x" }, ":", ";")
map("n", "q;", "q:")

-- Indent on paste
map("n", "=p", "<Plug>(YankyPutAfterFilter)")
map("n", "=P", "<Plug>(YankyPutBeforeFilter)")

-- Indent whole file
map("n", "<leader>=", "mzgg=G`zzz")

-- Toggle statusline
map("n", "<C-g>", function()
    if vim.o.laststatus == 0 then
        vim.o.laststatus = 2
        vim.cmd('set statusline="%F %m%=%l,%c"')
    else
        vim.o.laststatus = 0
        vim.cmd("set statusline=%{repeat('─',winwidth('.'))}")
    end
end)

-- Fix alpha.nvim <C-o> behavior
map('n', '<C-o>', function()
    if vim.bo.filetype == 'alpha' then
        -- Send <C-o> twice
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-o><C-o>', true, true, true), 'n', true)
    else
        -- Send <C-o> once
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-o>', true, true, true), 'n', true)
    end
end)

-- Unbind escape in terminal
map('t', '<Esc>', '<NOP>', { noremap = true })

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
            require('oil').open()
        end
    end)()
end

map('n', '<leader>po', ':lua fzf_cd({ "~/uni", "~/perso" }, "Projects> ")<CR>', { noremap = true, silent = true })
map('n', '<leader>pc', ':lua fzf_cd({ "~/.config" }, "Config> ")<CR>', { noremap = true, silent = true })
