return {
	'stevearc/oil.nvim',
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			columns = {
				"icon",
				"permissions",
				"size",
				"mtime",
			},
			delete_to_trash = true,
			watch_for_changes = true,
			view_options = {
				show_hidden = true,
			},
			git = {
				add = function(path)
					return true
				end,
				mv = function(path)
					return true
				end,
				rm = function(path)
					return true
				end,
			},
		})

		vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
	end,
}
