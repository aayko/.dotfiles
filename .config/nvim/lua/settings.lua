-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})
-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

vim.cmd([[ autocmd BufNewFile,BufRead *.json setlocal filetype=jsonc ]])

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.showmode = false

vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case

vim.opt.numberwidth = 2
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.smartindent = true
vim.opt.expandtab = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

vim.opt.clipboard = "unnamedplus"

-- Remove new line comment behaviour
vim.opt.formatoptions:remove({"c","r","o"})
vim.opt_local.formatoptions:remove({"c","r","o"})
vim.cmd([[autocmd BufNewFile,BufRead * setlocal formatoptions-=cro]])

vim.g.netrw_banner = 0

vim.opt.laststatus = 3

vim.opt.showtabline = 0

-- vim.opt.wrap = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
vim.opt.linebreak = true

-- vim.opt.cursorline = true

vim.opt.background = "dark"

-- split windows
vim.opt.splitright = true -- new vertical splits will appear on the right
vim.opt.splitbelow = true -- new horizontal splits will appear on the bottomvim.opt.iskeyword:append("-")

vim.opt.belloff = "all"

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = "0"
vim.opt.foldmethod = "indent"

vim.g.showmatch = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
