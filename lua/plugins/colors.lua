return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
				background = {
					light = "latte",
					dark = "macchiato",
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
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})

			-- vim.cmd("colorscheme catppuccin")
		end,
	},
	{ "rose-pine/neovim", name = "rose-pine", config = function() vim.cmd("colorscheme rose-pine-moon") end, }
}
