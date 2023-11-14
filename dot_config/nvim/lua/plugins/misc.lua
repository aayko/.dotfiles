return {
    {'tpope/vim-fugitive'},
    {
        'windwp/nvim-autopairs',
        enabled = true,
        event = "InsertEnter",
        opts = {},
    },
    {
        -- auto rename and closing tags for html
        'windwp/nvim-ts-autotag',
        opts = {
            autotag = true,
        }
    },
    {
        'gbprod/yanky.nvim',
        keys = {
            vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)"),
            vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)"),
        },
    },
    {
        'kylechui/nvim-surround',
        enabled = true,
        opts = {},
    },
    {
        'Wansmer/treesj',
        keys = { '<space>m', '<space>j', '<space>s' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {},
    },
    {
        'akinsho/toggleterm.nvim',
        opts = {
            open_mapping = [[<C-\>]],
            direction = "tab",
            shade_terminals = false,
        },
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
    },
    {
        'monaqa/dial.nvim',
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group{
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.decimal_int,
                    augend.integer.alias.hex,
                    augend.integer.alias.octal,
                    augend.integer.alias.binary,
                    augend.date.alias["%Y/%m/%d"],
                    augend.date.alias["%m/%d/%Y"],
                    augend.date.alias["%d/%m/%Y"],
                    augend.date.alias["%m/%d/%y"],
                    augend.date.alias["%d/%m/%y"],
                    augend.date.alias["%m/%d"],
                    augend.date.alias["%-m/%-d"],
                    augend.date.alias["%Y-%m-%d"],
                    augend.date.alias["%d.%m.%Y"],
                    augend.date.alias["%d.%m.%y"],
                    augend.date.alias["%d.%m."],
                    augend.date.alias["%-d.%-m."],
                    augend.date.alias["%H:%M:%S"],
                    augend.date.alias["%H:%M"],
                    augend.constant.alias.bool,
                    augend.semver.alias.semver,
                },
            }

            vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), {noremap = true})
            vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), {noremap = true})
            vim.keymap.set("n", "g<C-a>", require("dial.map").inc_gnormal(), {noremap = true})
            vim.keymap.set("n", "g<C-x>", require("dial.map").dec_gnormal(), {noremap = true})
            vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), {noremap = true})
            vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), {noremap = true})
            vim.keymap.set("v", "g<C-a>",require("dial.map").inc_gvisual(), {noremap = true})
            vim.keymap.set("v", "g<C-x>",require("dial.map").dec_gvisual(), {noremap = true})
        end
    },
    { "mbbill/undotree" },
    { "nvim-treesitter/playground" },
    { "andweeb/presence.nvim" },
}
