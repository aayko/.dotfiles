return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'natecraddock/workspaces.nvim',
        {
            'nvim-telescope/telescope-media-files.nvim',
            dependencies = {
                'nvim-lua/popup.nvim',
            }
        }
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
        telescope.load_extension('noice')
        telescope.load_extension('workspaces')
        telescope.load_extension('media_files')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set('n', '<leader>fs', builtin.lsp_dynamic_workspace_symbols, {})
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>cs', builtin.colorscheme, {})
        vim.keymap.set('n', '<leader>fc', '<CMD>cd $HOME/.config/nvim | Telescope find_files<CR>', {})

        vim.keymap.set('n', '<leader>w', telescope.extensions.workspaces.workspaces, {})
        -- vim.keymap.set('n', '<leader>n', telescope.extensions.noice.noice, {})
        vim.keymap.set('n', '<leader>fm', telescope.extensions.media_files.media_files, {})
        vim.keymap.set('n', '<leader>y', telescope.extensions.yank_history.yank_history, {})
    end,
}
