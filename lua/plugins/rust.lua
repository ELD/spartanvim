return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
		config = function()
			local lsp_custom = require("utils.lsp_custom")
			vim.g.rustaceanvim = {
				server = {
					on_attach = lsp_custom.on_attach,
				},
			}
		end
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			local lsp_custom = require("utils.lsp_custom")
			require("crates").setup({
				lsp = {
					enabled = true,
					on_attach = lsp_custom.on_attach,
					actions = true,
					completion = true,
					hover = true,
				},
				completion = {
					crates = {
						enabled = true,
						max_results = 8,
						min_chars = 3,
					},
				},
			})
		end,
	}
}
