return {
	"mrcjkb/rustaceanvim",
	version = "^5", -- Recommended
	lazy = false,   -- This plugin is already lazy
	config = function()
		local lsp_custom = require("utils.lsp_custom")
		vim.g.rustaceanvim = {
			server = {
				on_attach = lsp_custom.on_attach,
			},
		}
	end
}
