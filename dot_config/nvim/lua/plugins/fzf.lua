return {
    'ibhagwan/fzf-lua',
    enabled = true,
    cmd = 'FzfLua',
    init = function()
        vim.keymap.set("n", '<leader>pd', '<CMD>FzfLua lsp_document_diagnostics<CR>')
        vim.keymap.set("n", '<leader>pD', '<CMD>FzfLua lsp_workspace_diagnostics<CR>')
        vim.keymap.set("n", '<leader>pf', '<CMD>FzfLua files<CR>')
        vim.keymap.set("n", '<leader>pr', '<CMD>FzfLua lsp_references<CR>')
        vim.keymap.set("n", '<leader>ps', '<CMD>FzfLua lsp_document_symbols<CR>')
        vim.keymap.set("n", '<leader>pS', '<CMD>FzfLua lsp_workspace_symbols<CR>')
        vim.keymap.set("n", '<leader>pb', '<CMD>FzfLua buffers<CR>')
        vim.keymap.set("n", '<leader>pg', '<CMD>FzfLua live_grep_glob<CR>')
        vim.keymap.set("x", '<leader>pg', '<CMD>FzfLua grep_visual<CR>')
        vim.keymap.set("n", '<leader>ph', '<CMD>FzfLua help_tags<CR>')
        vim.keymap.set("n", '<leader>pH', '<CMD>FzfLua highlights<CR>')
        vim.keymap.set("n", '<leader>py', '<CMD>FzfLua oldfiles<CR>')
        vim.keymap.set("n", '<leader>pp', '<CMD>FzfLua resume<CR>')
        vim.keymap.set("n", '<leader>pb', function()
            require('fzf-lua').lgrep_curbuf {
                winopts = {
                    border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
                    height = 0.6,
                    width = 0.5,
                    preview = { vertical = 'up:70%' },
                },
            }
        end)
        vim.keymap.set("n", '<leader>p<esc>', '<nop>')
    end,
    opts = {
        fzf_colors = {
            ["bg"] = { "bg", "GruvboxBgO" },
            ["bg+"] = { "bg", "GruvboxBg1" },
            ["gutter"] = { "bg", "Normal" },
            ["info"] = { "fg", "GruvboxYellow" },
            ["scrollbar"] = { "bg", "Normal" },
            ["separator"] = { "fg", "Comment" },
            ["fg"] = { "fg", "GruvboxFg3" },
            ["fg+"] = { "fg", "GruvboxFg1" },
            ["hl"] = { "fg", "GruvboxBlue" },
            ["hl+"] = { "fg", "GruvboxBlue" },
            ["prompt"] = { "fg", "GruvboxYellow" },
            ["pointer"] = { "fg", "GruvboxAqua" },
            ["marker"] = { "fg", "GruvboxAqua" },
            ["spinner"] = { "fg", "GruvboxAqua" },
            ["header"] = { "fg", "GruvboxBlue" },
        },
        fzf_opts = {
            ['--info'] = 'default',
            ['--layout'] = 'reverse',
        },
        keymap = {
            builtin = {
                ['<C-/>'] = 'toggle-help',
                ['<C-a>'] = 'toggle-fullscreen',
                ['<C-i>'] = 'toggle-preview',
                ['<C-f>'] = 'preview-page-down',
                ['<C-b>'] = 'preview-page-up',
            },
            fzf = {
                ['alt-s'] = 'toggle',
                ['alt-a'] = 'toggle-all',
            },
        },
        winopts = {
            height = 1.0,
            width = 1.0,
            preview = {
                scrollbar = false,
                -- layout = 'vertical',
                vertical = 'up:50%',
            },
            border = "single",
        },
        global_git_icons = false,
        -- Configuration for specific commands.
        files = {
            winopts = {
                preview = { hidden = 'hidden' },
            },
        },
        lsp = {
            code_actions = {
                previewer = 'codeaction_native',
                preview_pager =
                "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit' --file-style='omit'",
            },
        },
        oldfiles = {
            include_current_session = true,
            winopts = {
                preview = { hidden = 'hidden' },
            },
        },
    }
}
