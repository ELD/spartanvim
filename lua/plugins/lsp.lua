-- INFO: Global file for all LSP related configuration
return {
	-- lspconfig and LspSaga
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "Mason" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"nvimdev/lspsaga.nvim",
			"folke/neodev.nvim",
		},
		opts = {
			inlay_hints = { enabled = true },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local lspconfig_win = require("lspconfig.ui.windows")
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local custom_lsp = require("utils.lsp_customizations")
			local lspsaga = require("lspsaga")
			local icons = require("utils.icons")

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

			local win = lspconfig_win
			local _default_opts = win.default_opts

			win.default_opts = function(options)
				local opts = _default_opts(options)
				opts.border = "single"
				return opts
			end

			local default_setup = function(server)
				lspconfig[server].setup({
					capabilities = custom_lsp.capabilities,
					on_attach = custom_lsp.on_attach,
				})
			end

			-- Configure neodev _before_ configuring lua_ls via Mason
			require("neodev").setup({})

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
					-- "rust_analyzer", -- WARN: Not required because rustaceanvim uses a preinstalled rust_analyzer?
					"sqls",
					"tailwindcss",
					"tsserver",
				},
				handlers = {
					rust_analyzer = custom_lsp.noop,
					lua_ls = function()
						lspconfig.lua_ls.setup({
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

			lspsaga.setup({
				preview = {
					lines_above = 0,
					lines_below = 10,
				},
				scroll_preview = {
					scroll_down = "<C-f>",
					scroll_up = "<C-b>",
				},
				request_timeout = 2000,
				finder = {
					--percentage
					max_height = 0.5,
					keys = {
						jump_to = "p",
						edit = { "o", "<CR>" },
						vsplit = "s",
						split = "i",
						tabe = "t",
						tabnew = "r",
						quit = { "q", "<ESC>" },
						close_in_preview = "<ESC>",
					},
				},
				definition = {
					edit = "<C-c>o",
					vsplit = "<C-c>v",
					split = "<C-c>i",
					tabe = "<C-c>t",
					quit = "q",
					close = "<Esc>",
				},
				code_action = {
					num_shortcut = true,
					show_server_name = false,
					extend_gitsigns = true,
					keys = {
						-- string | table type
						quit = "<ESC>",
						exec = "<CR>",
					},
				},
				lightbulb = {
					enable = true,
					enable_in_insert = false,
					sign = false,
					sign_priority = 40,
					virtual_text = false,
				},
				diagnostic = {
					show_code_action = true,
					show_source = true,
					jump_num_shortcut = true,
					--1 is max
					max_width = 0.7,
					custom_fix = nil,
					custom_msg = nil,
					text_hl_follow = false,
					border_follow = true,
					keys = {
						exec_action = "o",
						quit = "q",
						go_action = "g",
					},
				},
				rename = {
					quit = "<C-c>",
					exec = "<CR>",
					mark = "x",
					confirm = "<CR>",
					in_select = true,
				},
				outline = {
					win_position = "right",
					win_with = "",
					win_width = 30,
					show_detail = true,
					auto_preview = true,
					auto_refresh = true,
					auto_close = true,
					custom_sort = nil,
					keys = {
						jump = "o",
						expand_collapse = "u",
						quit = "q",
					},
				},
				symbol_in_winbar = {
					enable = true,
					separator = " - ",
					hide_keyword = true,
					show_file = true,
					folder_level = 2,
					respect_root = false,
					color_mode = true,
				},
				ui = {
					devicon = true,
					lightbulb = icons.ui.Lightbulb,
					kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
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
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
		config = function()
			local custom_lsp = require("utils.lsp_customizations")
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
