return {
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
            direction = "tab",
            shade_terminals = false,
            open_mapping = [[<c-\>]],
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
    { "simnalamburt/vim-mundo" },
    {
        "cameron-wags/rainbow_csv.nvim",
        config = true,
    },
    {
        "github/copilot.vim",
        enabled = true,
    },
    "chaoren/vim-wordmotion",
    {
        'goolord/alpha-nvim',
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            -- from https://github.com/geryzhydrox/Dotfiles
            dashboard.section.header.val = {
                "          ▗▄▄▄       ▗▄▄▄▄    ▄▄▄▖          ",
                "          ▜███▙       ▜███▙  ▟███▛          ",
                "           ▜███▙       ▜███▙▟███▛           ",
                "            ▜███▙       ▜██████▛            ",
                "     ▟█████████████████▙ ▜████▛     ▟▙      ",
                "    ▟███████████████████▙ ▜███▙    ▟██▙     ",
                "           ▄▄▄▄▖           ▜███▙  ▟███▛     ",
                "          ▟███▛             ▜██▛ ▟███▛      ",
                "         ▟███▛               ▜▛ ▟███▛       ",
                "▟███████████▛                  ▟██████████▙ ",
                "▜██████████▛                  ▟███████████▛ ",
                "      ▟███▛ ▟▙               ▟███▛          ",
                "     ▟███▛ ▟██▙             ▟███▛           ",
                "    ▟███▛  ▜███▙           ▝▀▀▀▀            ",
                "    ▜██▛    ▜███▙ ▜██████████████████▛      ",
                "     ▜▛     ▟████▙ ▜████████████████▛       ",
                "           ▟██████▙       ▜███▙             ",
                "          ▟███▛▜███▙       ▜███▙            ",
                "         ▟███▛  ▜███▙       ▜███▙           ",
                "         ▝▀▀▀    ▀▀▀▀▘       ▀▀▀▘           ",
            }
            dashboard.section.header.opts.hl = "Comment"
            dashboard.section.buttons.val = {
                dashboard.button("e", "New file", ":ene<CR>"),
                dashboard.button("r", "Recent", ":FzfLua oldfiles<CR>"),
                dashboard.button("n", "Nix", ":e $HOME/.config/nix/flake.nix<CR>"),
                dashboard.button("q", "Quit", ":qa!<CR>"),
            }
            alpha.setup(dashboard.opts)
        end
    },
    {
        "chrishrb/gx.nvim",
        keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
        cmd = { "Browse" },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gx").setup {
                handlers = {
                    plugin = true,
                },
                handler_options = {
                    search_engine = "https://www.startpage.com/sp/search?query=",
                },
            }
        end,
    },
}
