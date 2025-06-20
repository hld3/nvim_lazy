return {
    {
        -- LSP Configuration & Plugins
        {
            "neovim/nvim-lspconfig",
            config = function()
                local lspconfig = require("lspconfig")
                local on_attach = function(_, bufnr)
                    local nmap = function(keys, func, desc)
                        if desc then
                            desc = "LSP: " .. desc
                        end

                        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
                    end

                    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                    nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                    nmap("<leader>td", require("telescope.builtin").lsp_type_definitions, "[T]ype [D]efinition")
                    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
                        "[W]orkspace [S]ymbols")

                    -- See `:help K` for why this keymap
                    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                    nmap("<leader>d", vim.lsp.buf.signature_help, "Signature Documentation")

                    -- Lesser used LSP functionality
                    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
                    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
                    nmap("<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, "[W]orkspace [L]ist Folders")

                    -- Create a command `:Format` local to the LSP buffer
                    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                        vim.lsp.buf.format()
                    end, { desc = "Format current buffer with LSP" })
                end

                lspconfig.gopls.setup { on_attach = on_attach }
                lspconfig.lua_ls.setup { on_attach = on_attach }
            end
        },
        {
            -- Java
            "mfussenegger/nvim-jdtls",
        },
        {
            -- Autocompletion
            "hrsh7th/nvim-cmp",
            dependencies = {
                -- Snippet Engine & its associated nvim-cmp source
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",

                -- Adds LSP completion capabilities
                "hrsh7th/cmp-nvim-lsp",

                -- Adds a number of user-friendly snippets
                "rafamadriz/friendly-snippets",
            },
            config = function()
                local cmp = require("cmp")
                local luasnip = require("luasnip")
                cmp.setup({
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end,
                    },
                    mapping = cmp.mapping.preset.insert {
                        ["<C-n>"] = cmp.mapping.select_next_item(),
                        ["<C-p>"] = cmp.mapping.select_prev_item(),
                        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                        ["<C-f>"] = cmp.mapping.scroll_docs(4),
                        ["<C-Space>"] = cmp.mapping.complete {},
                        ["<CR>"] = cmp.mapping.confirm {
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = true,
                        },
                        ["<Tab>"] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif luasnip.expand_or_locally_jumpable() then
                                luasnip.expand_or_jump()
                            else
                                fallback()
                            end
                        end, { "i", "s" }),
                        ["<S-Tab>"] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif luasnip.locally_jumpable(-1) then
                                luasnip.jump(-1)
                            else
                                fallback()
                            end
                        end, { "i", "s" }),
                    },
                    window = {
                        completion = cmp.config.window.bordered(),
                        documentation = cmp.config.window.bordered(),
                    },
                    sources = {
                        { name = "nvim_lsp" },
                        { name = "luasnip" },
                    },
                })
            end
        },
    },
}
