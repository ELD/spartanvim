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
		local wk = require("which-key")
		wk.setup({
			plugins = {
				spelling = false,
			},
			win = {
				border = "single",
			},
		})
		wk.add({
			{ "<leader>s", group = "Search & Replace", },
			{ "<leader>f", group = "Telescope", },
			-- { "<leader>l", group = "LSP", },
		})
	end,
}
