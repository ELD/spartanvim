-- INFO: Global file for all LSP related configuration
return {
	-- Mason for managing LSPs, DAPs, linters, and formatters
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			local default_setup = function(server)
				require("lspconfig")[server].setup({
					capabilities = lsp_capabilities,
				})
			end

			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					},
				},
			})
			mason_lspconfig.setup({
				ensure_installed = {
					-- LSP
					"bashls",
					"cssls",
					"docker_compose_language_service",
					"dockerls",
					"eslint",
					"golangci_lint_ls",
					"gopls",
					"html",
					"lua_ls",
					"nil_ls",
					"rust_analyzer",
					"sqls",
					"tailwindcss",
					"tsserver",
				},
				handlers = {
					rust_analyzer = function() end,
					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							capabilities = lsp_capabilities,
							settings = {
								Lua = {
									runtime = {
										version = "LuaJIT",
									},
									diagnostics = {
										globals = { "vim" },
									},
									workspace = {
										library = {
											vim.env.VIMRUNTIME,
										},
									},
								},
							},
						})
					end,
					default_setup,
				},
			})
		end,
	},
	-- Completion plugins
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",    -- buffer completions
			"hrsh7th/cmp-path",      -- path completions
			"hrsh7th/cmp-cmdline",   -- cmdline completions
			"saadparwaiz1/cmp_luasnip", -- snippet completions
			"hrsh7th/cmp-nvim-lsp",
			-- snippets
			"L3MON4D3/LuaSnip",          --snippet engine
			"rafamadriz/friendly-snippets", -- a bunch of snippets to use
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			local function border(hl_name)
				return {
					{ "╭", hl_name },
					{ "─", hl_name },
					{ "╮", hl_name },
					{ "│", hl_name },
					{ "╯", hl_name },
					{ "─", hl_name },
					{ "╰", hl_name },
					{ "│", hl_name },
				}
			end

			cmp.setup({
				enabled = function()
					return vim.api.nvim_get_option_value("buftype", {
						buf = 0
					}) ~= "prompt"
				end,
				view = {
					entries = "custom"
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-y>"] = cmp.config.disable,
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, {
						"i", "s"
					}),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {
						"i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "crates" },
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				completion = {
					completeopt = "menu,menuone",
				},
				window = {
					completion = {
						scrollbar = false,
						winhighlight = "Normal:Cmpmenu,FloatBorder:Cmpmenu,CursorLine:PmenuSel,Search:None",
						border = border("CmpDocBorder"),
						side_padding = 0,
					},
					documentation = { winhighlight = "Normal:CmpDoc", border = border("CmpDocBorder") },
				}
			})

			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" },
				}, {
					{ name = "buffer" },
				})
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" }
				}
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" }
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" }
						}
					}
				})
			})
		end,
	},
	-- lspconfig and LspSaga
	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvimdev/lspsaga.nvim",
		},
		config = function()
			require("lspsaga").setup({
				symbol_in_winbar = {
					enable = true
				},
				ui = {
				},
			})
		end,
	},
	{
		'mrcjkb/rustaceanvim',
		version = '^4', -- Recommended
		ft = { 'rust' },
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
