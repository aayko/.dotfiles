return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground",
        "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
        require("nvim-treesitter.parsers")
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c",
                "lua",
                "nix",
                "vim",
                "vimdoc",
                "tsx",
                "javascript",
                "html",
                "css",
                "python",
                "bash",
                "json",
                "markdown",
                "regex",
                "java",
                "php",
                "haskell",
                "latex",
            },
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    scope_incremental = '<c-s>',
                    node_decremental = '<M-space>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']c'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']C'] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[c'] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[C'] = '@class.outer',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>i'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<leader>I'] = '@parameter.inner',
                    },
                },
            },
        })
    end
}
