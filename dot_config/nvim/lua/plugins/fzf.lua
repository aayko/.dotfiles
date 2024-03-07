return {
    'ibhagwan/fzf-lua',
    enabled = true,
    cmd = 'FzfLua',
    keys = {
        { '<leader>pp', '<CMD>FzfLua resume<CR>',                    desc = 'Resume last command' },
        {
            '<leader>pb',
            function()
                require('fzf-lua').lgrep_curbuf {
                    winopts = {
                        border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
                        height = 0.6,
                        width = 0.5,
                        preview = { vertical = 'up:70%' },
                    },
                }
            end,
            desc = 'Grep current buffer',
        },
        { '<leader>pd', '<CMD>FzfLua lsp_document_diagnostics<CR>',  desc = 'Document diagnostics' },
        { '<leader>pD', '<CMD>FzfLua lsp_workspace_diagnostics<CR>', desc = 'Workspace diagnostics' },
        { '<leader>pf', '<CMD>FzfLua files<CR>',                     desc = 'Find files' },
        { '<leader>pr', '<CMD>FzfLua lsp_references<CR>',            desc = 'References' },
        { '<leader>ps', '<CMD>FzfLua lsp_document_symbols<CR>',      desc = 'Symbols' },
        { '<leader>pS', '<CMD>FzfLua lsp_workspace_symbols<CR>',     desc = 'Workspace symbols' },
        { '<leader>pb', '<CMD>FzfLua buffers<CR>',                   desc = 'Find Buffers' },
        { '<leader>pg', '<CMD>FzfLua live_grep_glob<CR>',            desc = 'Grep' },
        { '<leader>pg', '<CMD>FzfLua grep_visual<CR>',               desc = 'Grep',                 mode = 'x' },
        { '<leader>ph', '<CMD>FzfLua help_tags<CR>',                 desc = 'Help' },
        { '<leader>pH', '<CMD>FzfLua highlights<CR>',                desc = 'Highlights' },
        { '<leader>py', '<CMD>FzfLua oldfiles<CR>',                  desc = 'Recently opened files' },
    },
    opts = function()
        local actions = require 'fzf-lua.actions'

        return {
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
            helptags = {
                actions = {
                    -- Open help pages in a vertical split.
                    ['default'] = actions.help_vert,
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
    end,
}
