return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        'goolord/alpha-nvim',
        enabled = true,
        event = "VimEnter",
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
                dashboard.button("fn", "  > New File", "<CMD>ene!<CR>"),
                dashboard.button("ff", "  > Find File", "<CMD>Telescope find_files<CR>"),
                dashboard.button("fr", "  > Recent Files", "<CMD>Telescope oldfiles<CR>"),
                dashboard.button("fg", "  > Find in Files", "<CMD>Telescope live_grep<CR>"),
                dashboard.button("fc", "  > Configuration", "<CMD>cd $HOME/.config/nvim | Telescope find_files<CR>"),
            }
            dashboard.section.buttons.opts.hl = "Comment"
            dashboard.section.header.opts.hl = "Function"
            alpha.setup(dashboard.opts)
        end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require("colorizer").setup {
                '*',
                '!notify',
            }
        end
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
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
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
                vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
                    { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
                vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
                    { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
                vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = '[P]review [H]unk' })
            end,
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        enabled = true,
        opts = {
            options = {
                disabled_filetypes = {'NvimTree', 'alpha'},
                icons_enabled = true,
                component_separators = '|',
                section_separators = '',
                -- component_separators = { left = '>', right = '<'},
                -- section_separators = { left = '', right = ''},
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { '' },
                lualine_c = { { 'branch' }, {
                    'filename',
                    symbols = {
                        modified = '●',
                    }
                } },
                -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_x = { 'filetype', 'progress' },
                lualine_y = { '' },
                -- lualine_y = { '' },
                lualine_z = { 'location' }
            },
        },
    },
}
