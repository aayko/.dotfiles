return {
    {
        "ThePrimeagen/harpoon",
        dependencies = "nvim-lua/plenary.nvim",
        branch = "harpoon2",
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup({
                settings = {
                    border_chars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                },
            })

            vim.keymap.set("n", "<leader>a", function()
                harpoon.list():append()
                vim.cmd('echo "' .. vim.fn.fnamemodify(vim.fn.expand('%'), ':t') .. ' added to harpoon"')
            end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        enabled = false,
        opts = {
            sync_root_with_cwd = true,
            hijack_directories = {
                enable = true,
                auto_open = true,
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
        },
    },
    {
        'stevearc/oil.nvim',
        config = true,
        opts = {},
    }
}
