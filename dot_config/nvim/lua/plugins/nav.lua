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
                harpoon:list():append()
                vim.cmd('echo "' .. vim.fn.fnamemodify(vim.fn.expand('%'), ':t') .. ' added to harpoon"')
            end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<C-h>", function()
                harpoon:list():select(1)
                vim.cmd [[normal zz]]
            end)

            vim.keymap.set("n", "<C-j>", function()
                harpoon:list():select(2)
                vim.cmd [[normal zz]]
            end)

            vim.keymap.set("n", "<C-k>", function()
                harpoon:list():select(3)
                vim.cmd [[normal zz]]
            end)

            vim.keymap.set("n", "<C-l>", function()
                harpoon:list():select(4)
                vim.cmd [[normal zz]]
            end)
        end
    },
    {
        "lmburns/lf.nvim",
        dependencies = "toggleterm.nvim",
        lazy = false,
        init = function()
            -- This feature will not work if the plugin is lazy-loaded
            vim.g.lf_netrw = 1

            vim.keymap.set("n", "<C-y>", "<Cmd>Lf<CR>")

            vim.api.nvim_create_autocmd("User", {
                pattern = "LfTermEnter",
                callback = function(a)
                    vim.api.nvim_buf_set_keymap(a.buf, "t", "q", "q", { nowait = true })
                    vim.api.nvim_buf_set_keymap(a.buf, "t", "<ESC>", "q", { nowait = true })
                    vim.api.nvim_buf_set_keymap(a.buf, "t", "<C-y>", "q", { nowait = true })
                end,
            })
        end,
        opts = {
            default_action = "drop",      -- default action when `Lf` opens a file
            winblend = 0,                 -- psuedotransparency level
            direction = "float",          -- window type: float horizontal vertical
            border = "single",            -- border kind: single double shadow curved
            height = vim.o.lines,         -- height of the *floating* window
            width = vim.o.columns,        -- width of the *floating* window
            escape_quit = true,           -- map escape to the quit command (so it doesn't go into a meta normal mode)
            focus_on_open = true,         -- focus the current file when opening Lf (experimental)
            mappings = false,             -- whether terminal buffer mapping is enabled
            default_file_manager = true,  -- make lf default file manager
            disable_netrw_warning = true, -- don't display a message when opening a directory with `default_file_manager` as true
        },
    },
    {
        'stevearc/oil.nvim',
        enabled = false,
        init = function()
            vim.keymap.set('n', '<C-y>', function()
                if vim.o.filetype == 'oil' then
                    require('oil').close()
                else
                    require('oil').open(vim.fn.getcwd())
                end
            end)

            -- Hide hidden files in notes directory
            vim.cmd [[ autocmd VimEnter * if luaeval('require("oil").get_current_dir()') == '/home/ayko/notes/' | call luaeval('require("oil").toggle_hidden()') | endif ]]
        end,
        opts = {
            delete_to_trash = true,
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-h>"] = "actions.select_vsplit",
                ["<C-s>"] = "actions.select_split",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["_"] = "actions.open_cwd",
                ["%"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            use_default_keymaps = false,
            skip_confirm_for_simple_edits = true,
        },
    }
}
