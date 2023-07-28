return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'natecraddock/workspaces.nvim',
    },
    opts = {
        defaults = {
            vimgrep_arguments = {
                'rg',
                '--color=always',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
                '--hidden',
                '-u',
            },
            layout_config = {
                horizontal = {
                    preview_cutoff = 100,
                },
            },
            file_ignore_patterns = {
                ".git/",
                ".cache",
                "%.o",
                "%.a",
                "%.out",
                "%.class",
                "%.pdf",
                "%.mkv",
                "%.mp4",
                "%.zip"
            },
        },
        pickers = {
            find_files = {
                hidden= true,
                find_commands = {
                    '--no-ignore-vcs',
                },
            },
            colorscheme = {
                enable_preview = true,
            },
        },
    },
    config = function(_, opts)
        local builtin = require('telescope.builtin')
        local telescope = require('telescope')

        telescope.load_extension('yank_history')
        telescope.load_extension('workspaces')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>cs', builtin.colorscheme, {})

        vim.keymap.set('n', '<leader>p', telescope.extensions.workspaces.workspaces, {})
        vim.keymap.set('n', '<leader>y', telescope.extensions.yank_history.yank_history, {})
    end,
}
