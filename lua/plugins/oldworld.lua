return {
	"dgox16/oldworld.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("oldworld").setup({
			terminal_colors = true,      -- enable terminal colors
			variant = "default",         -- default, oled, cooler
			styles = {                   -- You can pass the style using the format: style = true
				comments = { italic = true, }, -- style for comments
				keywords = { bold = true, }, -- style for keywords
				identifiers = {},          -- style for identifiers
				functions = { bold = true, }, -- style for functions
				variables = {},            -- style for variables
				booleans = {},             -- style for booleans
			},
			integrations = {             -- You can disable/enable integrations
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

		vim.cmd([[colorscheme oldworld]])
	end,
}
