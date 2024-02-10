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
			local custom_lsp = require("utils.lsp")
			local default_setup = function(server)
				require("lspconfig")[server].setup({
					capabilities = custom_lsp.capabilities,
					on_attach = custom_lsp.on_attach,
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
					rust_analyzer = custom_lsp.noop,
					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							on_attach = custom_lsp.on_attach,
							capabilities = custom_lsp.capabilities,
							settings = {
								Lua = {
									runtime = {
										version = "LuaJIT",
										path = "$VIMRUNTIME/lua",
									},
									diagnostics = {
										globals = { "vim" },
										neededFileStatus = {
											["codestyle-check"] = "Any",
										},
									},
									workspace = {
										library = {
											[vim.fn.expand("$VIMRUNTIME/lua")] = true,
											[vim.fn.stdpath("config") .. "/lua"] = true,
										},
									},
									format = {
										enable = true,
										defaultConfig = {
											indent_style = "tab",
											indent_size = "2",
											quote_style = "double",
											max_line_length = "unset",
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
		opts = {
			inlay_hints = { enabled = true },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local icons = require("utils.icons")
			-- local lsp = require("utils.lsp")

			local signs = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
				{ name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
				{ name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
				{ name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
			}
			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
			end

			vim.diagnostic.config(
				{
					virtual_text = { prefix = icons.ui.VirtualPrefix },
					signs = { active = signs, },
					update_in_insert = true,
					underline = true,
					severity_sort = true,
					float = {
						focusable = false,
						style = "minimal",
						border = "single",
						source = "always",
						header = "",
						prefix = "",
					},
				}
			)
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "single"
			})
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "single",
				focusable = true,
				relative = "cursor",
			})

			---@diagnostic disable-next-line: duplicate-set-field
			vim.notify = function(msg, log_level)
				if msg:match "exit code" then
					return
				end
				if log_level == vim.log.levels.ERROR then
					vim.api.nvim_err_writeln(msg)
				else
					vim.api.nvim_echo({ { msg } }, true, {})
				end
			end

			local win = require("lspconfig.ui.windows")
			local _default_opts = win.default_opts

			win.default_opts = function(options)
				local opts = _default_opts(options)
				opts.border = "single"
				return opts
			end

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
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
		config = function()
			local custom_lsp = require("utils.lsp")
			vim.g.rustaceanvim = {
				tools = {},
				server = {
					on_attach = custom_lsp.on_attach,
					settings = {
						["rust-analyzer"] = {},
					},
				},
				dap = {},
			}
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
