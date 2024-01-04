return {
    'nvim-telescope/telescope.nvim',
    enabled = false,
    tag = '0.1.2',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    },
    config = function(_, opts)
        local builtin = require('telescope.builtin')
        local telescope = require('telescope')

        require('telescope').setup({
            defaults = {
                borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                file_ignore_patterns = {
                    ".git/",
                    ".cache",
                    "%.o",
                    "%.a",
                    "%.out",
                    "%.class",
                },
            },
        })

        require('telescope').load_extension('fzf')
        require("telescope").load_extension("undo")
        vim.keymap.set("n", "<leader>u", "<CMD>Telescope undo<CR>")

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set('n', '<leader>ps', builtin.lsp_dynamic_workspace_symbols, {})
        vim.keymap.set('n', '<leader>pd', builtin.diagnostics, {})
        vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>pr', builtin.oldfiles, {})
        vim.keymap.set('n', '<leader>pc', '<CMD>cd $HOME/.config/nvim<CR>', {})

        vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
    end,
}
