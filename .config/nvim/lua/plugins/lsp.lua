return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        { 'neovim/nvim-lspconfig' },
        {
            'williamboman/mason.nvim',
            config = function()
                require("mason").setup({
                    ui = {
                        border = "rounded"
                    }
                })
            end,
            build = function()
                pcall(vim.api.nvim_command, 'MasonUpdate')
            end,
        },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-nvim-lsp' },

        { 'onsails/lspkind.nvim' },

        {
            'L3MON4D3/LuaSnip',
            dependencies = { "rafamadriz/friendly-snippets" },
        },
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        lsp.ensure_installed({
            'bashls',
            'lua_ls',
            'cmake',
            'cssls',
            'clangd',
            'jdtls',
            'html',
            'emmet_language_server',
            'vimls',
            'pyright',
        })

        -- Fix Undefined global 'vim'
        lsp.configure('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        })

        local lspkind = require('lspkind')
        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
            ["<C-Space>"] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        })

        cmp.setup({
            window = {
                completion = cmp.config.window.bordered({
                    winhighlight = 'Normal:None,FloatBorder:IndentBlanklineChar,CursorLine:PmenuSel,Search:None',
                    scrollbar = false,
                }),
                documentation = cmp.config.window.bordered({
                    winhighlight = 'Normal:None,FloatBorder:IndentBlanklineChar,CursorLine:PmenuSel,Search:None',
                }),
            },
        })

        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
        })

        lsp.setup_nvim_cmp {
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = '...',
                })
            },
            mapping = cmp_mappings,
        }

        -- vim.cmd([[
        --     highlight! link CmpPmenu         Pmenu
        --     highlight! link CmpPmenuBorder   Pmenu
        --     ]])

        lsp.set_preferences({
            suggest_lsp_servers = true,
        })

        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, opts)

        end)

        lsp.setup()

        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        vim.diagnostic.config({
            virtual_text = false,
            underline = true,
            update_in_insert = false,
        })

    end,
}
