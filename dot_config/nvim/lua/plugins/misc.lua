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
                width = function()
                    return vim.o.columns
                end,
                height = function()
                    return vim.o.lines
                end,
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
        enabled = true,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            "github/copilot.vim",
            "nvim-lua/plenary.nvim",
        },
        init = function()
            vim.keymap.set("n", "<C-p>", vim.cmd.CopilotChatToggle)
        end,
        opts = {
            model = 'gpt-4',
            show_help = false,
            window = {
                layout = "float",
                title = "Copilot",
                width = 1,
                height = 1,
            },
        },
    },
    { "chaoren/vim-wordmotion" },
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
