return {
    {
        'ThePrimeagen/harpoon',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", function()
                mark.add_file()
                vim.cmd('echo "' .. vim.fn.fnamemodify(vim.fn.expand('%'), ':t') .. ' added to harpoon"')
            end)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end)
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        opts = {
            sync_root_with_cwd = true,
            view = {
                width = 30,
                side = "right",
            },
            hijack_directories = {
                enable = false,
                auto_open = false,
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
        },
    },
    {
        'natecraddock/workspaces.nvim',
        keys = {
            {'<leader>wa', '<CMD>WorkspacesAdd<CR>' }
        },
        opts = {},
    },
    {
        "folke/flash.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = {
            modes = {
                char = {
                    enabled = false,
                },
                search = {
                    enabled = false,
                },
            },
        },
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        },
    },
}
