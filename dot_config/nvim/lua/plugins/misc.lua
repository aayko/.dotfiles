return {
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            require("mini.sessions").setup()
            local starter = require("mini.starter")

            starter.setup({
                items = {
                    -- starter.sections.sessions(5, true),
                    starter.sections.recent_files(5, false, false),
                    starter.sections.builtin_actions(),
                },
                footer = "",
                header = "Neovim",
            })

        end
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
    },
    { "vim-scripts/ReplaceWithRegister" },
    { 'tpope/vim-fugitive' },
    {
        -- auto rename and closing tags for html
        'windwp/nvim-ts-autotag',
        opts = {
            autotag = true,
        }
    },
    {
        'gbprod/yanky.nvim',
        opts = {
            highlight = {
                on_put = false,
                on_yank = true,
                timer = 150,
            },
        },
    },
    {
        'kylechui/nvim-surround',
        enabled = true,
        opts = {},
    },
    {
        'Wansmer/treesj',
        keys = { '<space>m' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {},
    },
    {
        'akinsho/toggleterm.nvim',
        opts = {
            open_mapping = [[`]],
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
            require("dial.config").augends:register_group {
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.decimal_int,
                    augend.integer.alias.hex,
                    augend.integer.alias.octal,
                    augend.integer.alias.binary,
                    augend.constant.alias.bool,
                    augend.semver.alias.semver,
                },
            }

            vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
            vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
            vim.keymap.set("n", "g<C-a>", require("dial.map").inc_gnormal(), { noremap = true })
            vim.keymap.set("n", "g<C-x>", require("dial.map").dec_gnormal(), { noremap = true })
            vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
            vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
            vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
            vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
        end
    },
    { "mbbill/undotree" },
    { "mechatroner/rainbow_csv" },
    { "github/copilot.vim" },
}

