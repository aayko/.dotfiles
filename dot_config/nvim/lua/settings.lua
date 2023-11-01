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

vim.g.netrw_banner = 0

vim.opt.showtabline = 0

-- vim.opt.wrap = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true

vim.opt.cursorline = false

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

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.pumheight = 8
vim.g.lsp_preview_max_width = 8

vim.cmd([[
    set laststatus=0
    hi! link StatusLine Comment
    hi! link StatusLineNC Comment
    set statusline=%{repeat('─',winwidth('.'))}
]])

require("noirbuddy").setup{
    preset = 'minimal',
    colors = {
        primary = '#689d6a',
        secondary = '#458588',
        background = '#080808',
        diagnostic_error = '#ffffff',
        diagnostic_warning = '#ffffff',
        diagnostic_info = '#ffffff',
        diagnostic_hint = '#ffffff',
    }
}
vim.cmd([[
    " completion border color
    hi IndentBlanklineChar guifg=#222222

    hi @ibl.indent.char.1 guifg=#222222
    hi @ibl.scope.char.1 guifg=#ffffff

    hi WinSeparator guibg=#080808 guifg=#333333
    hi IncSearch guibg=#689d6a guifg=ffffff

    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=150})
    augroup END
]])
