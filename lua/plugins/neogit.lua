return {
	{
		"NeogitOrg/neogit",
		config = true
	},
	{ "nvim-lua/plenary.nvim", lazy = true },  -- required
	{ "sindrets/diffview.nvim", lazy = true }, -- optional - Diff integration

	-- Only one of these is needed, not both.
	{ "nvim-telescope/telescope.nvim", lazy = true }, -- optional
	{ "ibhagwan/fzf-lua", lazy = true },              -- optional
}
