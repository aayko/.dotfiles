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
                char = "│"
            },
            scope = {
                enabled = true,
                show_start = false,
                show_end = false,
            }
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
