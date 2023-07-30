return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        'goolord/alpha-nvim',
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            dashboard.section.header.val = {
                "                                                    ",
                " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                "                                                    "
            }
            dashboard.section.buttons.val = {
                dashboard.button( "fn", "  > New File", "<CMD>ene!<CR>"),
                dashboard.button( "ff", "  > Find File", "<CMD>Telescope find_files<CR>"),
                dashboard.button( "fr", "  > Recent Files", "<CMD>Telescope oldfiles<CR>"),
                dashboard.button( "fg", "  > Find in Files", "<CMD>Telescope live_grep<CR>"),
                dashboard.button( "fc", "  > Configuration", "<CMD>cd $HOME/.config/nvim | Telescope find_files<CR>"),
            }
            dashboard.section.buttons.opts.hl = "Comment"
            alpha.setup(dashboard.opts)
        end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        opts = {},
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        opts = {
            indent_blankline_use_treesitter = true,
            show_current_context = true,
        },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            routes = {
                {
                    view = "notify",
                    filter = { event = "msg_showmode" },
                },
            },
            presets = {
                command_palette = true,
                lsp_doc_border = true,
            }
        },
    },
    {
        'rcarriga/nvim-notify',
        opts = {
            fps = 60,
            minimum_width = 40,
            stages = "static",
            render = "minimal",
            timeout = 2000,
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
                vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
                vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
            end,
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
                component_separators = '|',
                section_separators = '',
                sections = {
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,
                            path = 2,
                        },
                    },
                },
            },
        },
    },
}
