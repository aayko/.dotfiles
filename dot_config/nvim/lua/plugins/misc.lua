return {
    { "vim-scripts/ReplaceWithRegister" },
    {
        'tpope/vim-fugitive',
        init = function()
            vim.keymap.set("n", "<leader>g", "<CMD>tab G<CR>")
        end
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
        init = function()
            vim.keymap.set('t', '<Esc>', '<nop>', { noremap = true })
        end,
        opts = {
            open_mapping = [[<c-\>]],
            shade_terminals = false,
            direction = 'float',
            float_opts = {
                border = "single",
                width = vim.o.columns,
                height = vim.o.lines
            },
            highlights = {
                FloatBorder = {
                    link = "WinSeparator"
                },
            },
        },
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            ignore = '^$'
        },
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
        enabled = false,
    },
    "chaoren/vim-wordmotion",
    {
        'goolord/alpha-nvim',
        init = function()
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
        end,
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
        cmd = { "Browse" },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx
            vim.keymap.set({ "n", "x" }, "gx", vim.cmd.Browse)
        end,
        dependencies = "nvim-lua/plenary.nvim",
        opts = {
            handlers = {
                plugin = true,
            },
            handler_options = {
                search_engine = "https://www.startpage.com/sp/search?query=",
            },
        }
    },
}
