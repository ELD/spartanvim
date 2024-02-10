return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({
			settings = {
				save_on_toggle = true,
			},
		})

		local keymap = vim.keymap.set

		keymap("n", "<leader>a", function() harpoon:list():append() end, { desc = "Harpoon: Append to list" })
		keymap("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Toggle Quick Menu" })

		keymap("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Harpoon Select 1" })
		keymap("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "Harpoon Select 2" })
		keymap("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Harpoon Select 2" })
		keymap("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "Harpoon Select 2" })
	end,
}

