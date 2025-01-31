return {
	{
		"dgox16/oldworld.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("oldworld").setup({
				terminal_colors = true,
				variants = "default",
				styles = {
					comments = {}, -- Change the style of comments
					functions = {},
					keywords = {},
					variables = {},
					booleans = {},
				},
				integrations = {
					alpha = true,
					cmp = true,
					gitsigns = true,
					hop = true,
					indent_blankline = true,
					lazy = true,
					lsp = true,
					markdown = true,
					mason = true,
					noice = true,
					notify = true,
					telescope = true,
					treesitter = true,
				},
			})
			vim.cmd("colorscheme oldworld")
		end,
	},
	{
		"f-person/auto-dark-mode.nvim",
		enabled = false,
		opts = {
			update_interval = 1000,
			set_dark_mode = function()
				vim.api.nvim_set_option_value("background", "dark", {})
			end,
			set_light_mode = function()
				vim.api.nvim_set_option_value("background", "light", {})
			end,
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "frappe",
				background = {
					light = "latte",
					dark = "frappe",
				},
				transparent_background = false,
				show_end_of_buffer = false,
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false,
				no_bold = false,
				no_underline = false,
				-- styles = {
				-- 	comments = { "italic" }, -- Change the style of comments
				-- 	conditionals = { "italic" },
				-- 	loops = { "underline" },
				-- 	functions = { "bold" },
				-- 	keywords = { "bold" },
				-- 	strings = { "italic" },
				-- 	variables = {},
				-- 	numbers = {},
				-- 	booleans = {},
				-- 	properties = {},
				-- 	types = { "italic", "undercurl" },
				-- 	operators = {},
				-- },
				color_overrides = {},
				custom_highlights = {},
				integrations = {
					barbar = true,
					cmp = true,
					gitsigns = true,
					harpoon = true,
					nvimtree = true,
					telescope = {
						enabled = true,
					},
					treesitter = true,
					notify = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})

			-- vim.cmd("colorscheme catppuccin")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			-- vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
			-- vim.cmd("colorscheme gruvbox")
		end
	},
	{
		"yorumicolors/yorumi.nvim",
		config = function()
			-- vim.cmd("colorscheme yorumi")
		end,
	},
	{
		"gbprod/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nord").setup({
				styles = {
					conditionals = { italic = true },
					comments = { italic = true }, -- Change the style of comments
					loops = { underline = true },
					functions = { bold = true },
					keywords = { bold = true },
					strings = { italic = true },
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = { italic = true, undercurl = true },
					operators = {},
					bufferline = {
						current = {},
						modified = { italic = true },
					},
				},
			})
			-- vim.cmd.colorscheme("nord")
		end,
	},
}
