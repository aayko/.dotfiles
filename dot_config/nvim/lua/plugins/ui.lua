return {
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
        main = "ibl",
        opts = {
            indent = {
                char = "⎜"
            },
            scope = {
                enabled = true,
                show_start = false,
                show_end = false,
            }
        },
    },
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
                local gitsigns = require("gitsigns");

                vim.keymap.set('n', '[h', function()
                    gitsigns.prev_hunk({ buffer = bufnr })
                    gitsigns.preview_hunk({ buffer = bufnr })
                end, { buffer = bufnr })

                vim.keymap.set('n', ']h', function()
                    gitsigns.next_hunk({ buffer = bufnr })
                    gitsigns.preview_hunk({ buffer = bufnr })
                end, { buffer = bufnr })

                vim.keymap.set('n', 'gh', gitsigns.preview_hunk, { buffer = bufnr })
            end,
        },
    },
}
