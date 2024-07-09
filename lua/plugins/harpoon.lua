return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		local conf = require("telescope.config").values
		local keymap = vim.keymap.set

		harpoon:setup()

		keymap("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add to Harpoon List" })
		keymap("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Show Harpoon list" })
		keymap("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Go to #1" })
		keymap("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "Go to #2" })
		keymap("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Go to #3" })
		keymap("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "Go to #4" })

		keymap("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Go to previous" })
		keymap("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Go to next" })
	end,
}
