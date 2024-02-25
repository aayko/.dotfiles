vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.showmode = false

vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true  -- smart case

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

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

vim.opt.clipboard = "unnamedplus"

vim.g.netrw_banner = 0

vim.opt.showtabline = 0

-- vim.opt.wrap = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true

vim.opt.background = "dark"

-- split windows
vim.opt.splitright = true -- new vertical splits will appear on the right
vim.opt.splitbelow = true -- new horizontal splits will appear on the bottom

vim.opt.iskeyword:remove("_")

vim.opt.belloff = "all"

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = "0"
vim.opt.foldmethod = "indent"

vim.g.showmatch = true

vim.opt.cursorline = true
vim.opt.cursorlineopt = "line"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.pumheight = 8
vim.g.lsp_preview_max_width = 8

vim.opt.timeout = false
vim.opt.ttimeout = false

-- Use ripgrep for grepping.
vim.o.grepprg = 'rg --vimgrep'
vim.o.grepformat = '%f:%l:%c:%m'

vim.cmd([[
    function! g:DisableMatchParen ()
    if exists(":NoMatchParen")
        :NoMatchParen
        endif
        endfunction

        augroup plugin_initialize
    autocmd!
    autocmd VimEnter * call DisableMatchParen()
    augroup END
]])

-- Number of recent files
vim.opt.shada = "!,'300,<50,s10,h"

vim.cmd("set viminfofile=")

-- Hide status bar (toggle with <C-g>)
vim.o.laststatus = 0
vim.cmd("set statusline=%{repeat('─',winwidth('.'))}")

-- Hide command line
vim.o.cmdheight = 0

-- Block in insert mode
vim.opt.guicursor = ""

vim.cmd("colorscheme gruvbox")

vim.api.nvim_set_hl(0, "@ibl.scope.char.1", { fg = "#fe8019" })

vim.api.nvim_set_hl(0, "Visual", { bg = "#3c3836" })

-- cleaner window separator
vim.api.nvim_set_hl(0, "WinSeparator", { link = "@ibl.whitespace.char.1" })
vim.api.nvim_set_hl(0, "StatusLine", { link = "WinSeparator" })
vim.api.nvim_set_hl(0, "StatusLineNC", { link = "WinSeparator" })

vim.api.nvim_set_hl(0, "YankyYanked", { link = "IncSearch" })

vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "@ibl.whitespace.char.1" })
vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "@ibl.whitespace.char.1" })
