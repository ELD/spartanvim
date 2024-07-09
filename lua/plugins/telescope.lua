-- TODO: More configuration
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- or                              , branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local keymap = vim.keymap.set

		keymap("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true, desc = "Telescope Find Files" })
		keymap("n", "<leader>fg", builtin.live_grep, { noremap = true, silent = true, desc = "Telescope Live Grep" })
		keymap("n", "<leader>fb", builtin.buffers, { noremap = true, silent = true, desc = "Telescope Find Buffers" })
		keymap("n", "<leader>fh", builtin.help_tags, { noremap = true, silent = true, desc = "Telescope Helptags" })
		keymap("n", "<leader>fx", builtin.quickfix, { noremap = true, silent = true, desc = "Telescope Quickfix List" })
		keymap("n", "<leader>fn", "<cmd>Telescope noice<CR>", { noremap = true, silent = true, desc = "Telescope Noice" })

		telescope.setup({})
		telescope.load_extension("noice")
	end,
}
