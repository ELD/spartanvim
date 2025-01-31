return {
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "Mason" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			inlay_hints = { enabled = true },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local custom_lsp = require("utils.lsp_custom")
			-- local lspsaga = require("lspsaga")
			local none_ls = require("null-ls")
			local mason_none_ls = require("mason-null-ls")

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
					"htmx",
					"jsonls",
					"lua_ls",
					"nil_ls",
					"rust_analyzer",
					"sqls",
					"tailwindcss",
					"templ",
					"terraformls",
					"ts_ls",
					"yamlls",
				},
				handlers = {
					rust_analyzer = custom_lsp.noop,
					yamlls = function()
						lspconfig.yamlls.setup({
							on_attach = custom_lsp.on_attach,
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						})
					end,
					jsonls = function()
						lspconfig.jsonls.setup({
							on_attach = custom_lsp.on_attach,
							settings = {
								json = {
									schemas = require("schemastore").json.schemas(),
									validate = { enable = true },
								},
							},
						})
					end,
					html = function()
						lspconfig.html.setup({
							on_attach = custom_lsp.on_attach,
							filetypes = { "html", "templ" },
						})
					end,
					htmx = function()
						lspconfig.htmx.setup({
							on_attach = custom_lsp.on_attach,
							filetypes = { "html", "templ" },
						})
					end,
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
			-- TODO: None-ls configuration
			mason_none_ls.setup({
				ensure_installed = {
					"statix",
				},
				automatic_installation = false,
				handlers = {},
			})
			none_ls.setup({
				sources = {},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		enabled = false,
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

			local check_backspace = function()
				local col = vim.fn.col "." - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
			end
			local options = {
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
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if luasnip.expandable() then
							cmp.close()
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							cmp.close()
							luasnip.expand_or_jump()
						elseif cmp.visible() then
							cmp.select_next_item()
						elseif check_backspace() then
							fallback()
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
			}

			-- options = vim.tbl_deep_extend("force", options, require("nvchad.cmp"))
			cmp.setup(options)

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
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			local lsp_lines = require("lsp_lines")
			vim.diagnostic.config({
				virtual_text = false
			})
			lsp_lines.setup()
			lsp_lines.toggle()
			vim.keymap.set("", "<leader>l", lsp_lines.toggle, { desc = "[lsp_lines] Toggle", silent = true })
		end,
	},
	{ "williamboman/mason.nvim",           lazy = true },
	{ "williamboman/mason-lspconfig.nvim", lazy = true },
	{ "nvimdev/lspsaga.nvim", },
	{ "folke/neodev.nvim", },
	{ "b0o/schemastore.nvim",              lazy = true },
	{ "nvimtools/none-ls.nvim",            lazy = true },
	{ "jay-babu/mason-null-ls.nvim",       lazy = true },
	{ "hrsh7th/cmp-buffer", enabled = false },                -- buffer completions
	{ "hrsh7th/cmp-path", enabled = false },                  -- path completions
	{ "hrsh7th/cmp-cmdline", enabled = false },               -- cmdline completions
	{ "saadparwaiz1/cmp_luasnip", enabled = false },          -- snippet completions
	{ "hrsh7th/cmp-nvim-lsp", enabled = false },
	{ "L3MON4D3/LuaSnip", enabled = false },                  --snippet engine
	{ "rafamadriz/friendly-snippets", enable = false },      -- a bunch of snippets to use
}
