return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false, -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway
		config = function()
			require("markview.extras.checkboxes").setup();
			require("markview.extras.editor").setup();
			require("markview.extras.headings").setup();

			local keymap = vim.keymap.set

			keymap("n", "<leader>cb", ":Checkbox interactive<CR>", { silent = true, desc = "Checkbox Ineractive" })
			keymap("n", "<leader>hu", ":Headings increase<CR>", { silent = true, desc = "Increase Heading" })
			keymap("n", "<leader>hf", ":Headings decrease<CR>", { silent = true, desc = "Decrease Heading" })
			keymap("n", "<leader>mc", ":CodeCreate<CR>", { silent = true, desc = "Create a codeblock" })
			keymap("n", "<leader>me", ":CodeEdit<CR>", { silent = true, desc = "Edit a codeblock" })
		end,

	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
}
