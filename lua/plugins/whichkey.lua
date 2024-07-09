return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function()
		local which_key = require("which-key")
		which_key.setup({
			plugins = {
				spelling = false,
			},
			window = {
				border = "single",
			},
		})

		which_key.register({
			mode = { "n" },
			["<leader>s"] = { name = "Search & Replace" },
			["<leader>f"] = { name = "Telescope" },
			["<leader>l"] = { name = "LSP" },
		})
	end,
}
