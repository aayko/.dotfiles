return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        {
            "jay-babu/mason-null-ls.nvim",
            event = { "BufReadPre", "BufNewFile" },
            dependencies = {
                "williamboman/mason.nvim",
                "nvimtools/none-ls.nvim",
                "lukas-reineke/lsp-format.nvim",
            },
            config = function()
                require("mason-null-ls").setup({
                    ensure_installed = {
                        "stylua",
                        "shellcheck",
                        "clang-format",
                        "pretty-php",
                    }
                })
            end
        },
        -- Autocompletion
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        {
            'L3MON4D3/LuaSnip',
            dependencies = { "rafamadriz/friendly-snippets" },
        },
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require('lspconfig.ui.windows').default_options.border = 'single'

        -- Snippets select mode mappings
        local ls = require("luasnip")
        vim.keymap.set({ "i" }, "<C-j>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true })
        vim.keymap.set({ "s" }, "<C-j>", function() ls.jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(-1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-e>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, { silent = true })

        local cmp = require 'cmp'
        cmp.setup({
            snippet = {
                expand = function(args)
                    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end,
            },

            formatting = {
                fields = { "abbr", "kind" },
                format = function(entry, vim_item)
                    vim_item.abbr = vim_item.abbr:match("[^(]+")
                    vim_item.menu = nil

                    local source = entry.source.name
                    if source == "luasnip" or source == "nvim_lsp" then
                        vim_item.dup = 0
                    end

                    return vim_item
                end
            },
            window = {
                completion = cmp.config.window.bordered({
                    border = "single",
                    scrollbar = false,
                }),
                documentation = cmp.config.window.bordered({
                    border = "single",
                    scrollbar = false,
                }),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
                { name = 'path' },
            })
        })

        -- Use buffer source for `/` and `?`
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':'
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'cmdline' },
            }),
        })

        require("mason").setup({
            ui = {
                border = "single",
                icons = {
                    package_installed = "●",
                    package_pending = "○",
                    package_uninstalled = "○"
                }
            }
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                'bashls',
                -- 'clangd',
                'jdtls',
                'html',
                'emmet_language_server',
                'cssls',
                -- 'lua_ls',
                'vimls',
                -- 'rnix',
            },
        })

        -- Set up lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require("lspconfig")
        local lspformat = require("lsp-format")

        lspformat.setup {}

        -- Language servers
        lspconfig.hls.setup {
            on_attach = lspformat.on_attach,
        }

        lspconfig.clangd.setup {
            on_attach = lspformat.on_attach,
        }

        lspconfig.lua_ls.setup {
            on_attach = lspformat.on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    }
                }
            }
        }

        lspconfig.intelephense.setup {
            on_attach = lspformat.on_attach
        }

        lspconfig.texlab.setup {}
        lspconfig.rnix.setup {}

        require("mason-lspconfig").setup_handlers {
            function(server_name) -- default handler (optional)
                lspconfig[server_name].setup {
                    capabilities = capabilities,
                }
            end,

            -- ["lua_ls"] = function()
            --     lspconfig.lua_ls.setup {
            --             -- cmd = { "/run/current-system/sw/bin/lua-language-server" },
            --         settings = {
            --             Lua = {
            --                 diagnostics = {
            --                     globals = { "vim" }
            --                 }
            --             }
            --         }
            --     }
            -- end,
        }

        vim.diagnostic.config({
            virtual_text = false,
            underline = false,
            update_in_insert = false,
        })

        vim.api.nvim_create_user_command(
            'DiagnosticsToggleVirtualText',
            function()
                local current_value = vim.diagnostic.config().virtual_text
                if current_value then
                    vim.diagnostic.config({ virtual_text = false })
                else
                    vim.diagnostic.config({ virtual_text = true })
                end
            end,
            {}
        )

        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or 'single'
            opts.max_width = opts.max_width or 60
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'


                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>f', function()
                    vim.lsp.buf.format { async = true }
                end, opts)
            end,
        })
    end
}
