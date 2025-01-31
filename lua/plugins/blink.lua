return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",

	version = "v0.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		completion = {
			documentation = {
				treesitter_highlighting = true,
			},
			ghost_text = {
				enabled = true,
			},
			menu = {
				draw = {
					treesitter = { "lsp", "path", "snippets", "buffer" },
				},
			},
		},
		keymap = { preset = "default" },
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono"
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		signature = { enabled = true }
	},
	opts_extend = { "sources.default" },
	config = function()
		require("blink.cmp").setup({
			completion = {
				menu = {
					draw = {
						-- We don't need label_description now because label and label_description are already
						-- conbined together in label by colorful-menu.nvim.
						columns = { { "kind_icon" }, { "label", gap = 1 } },
						components = {
							label = {
								text = require("colorful-menu").blink_components_text,
								highlight = require("colorful-menu").blink_components_highlight,
							},
						},
					},
				},
				documentation = {
					treesitter_highlighting = true,
				},
				ghost_text = {
					enabled = true,
				},
			},
			keymap = { preset = "default" },
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono"
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			signature = { enabled = true }
		})
	end,
}
