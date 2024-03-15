return {
	{
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
			keymap("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Harpoon Select 3" })
			keymap("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "Harpoon Select 4" })
		end,
	},
	{
		"nvim-lua/popup.nvim",
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			local npairs = require("nvim-autopairs")

			npairs.setup({
				check_ts = true,
				ts_config = {
					lua = { "string", "source" },
					javascript = { "string", "template_string" },
				},
				disable_filetype = { "TelescopePrompt", "spectre_panel" },
				fast_wrap = {
					map = "<M-e>",
					chars = { "{", "[", "(", '"', "'" },
					pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
					offset = 0,
					end_key = "$",
					keys = "qwertyiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "PmenuSel",
					highlight_grey = "LineNr",
				},
			})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
		end,
	},
	{
		"utilyre/sentiment.nvim",
		version = "*",
		event = "VeryLazy", -- keep for lazy loading
		opts = {
			-- config
		},
		init = function()
			-- `matchparen.vim` needs to be disabled manually in case of lazy loading
			vim.g.loaded_matchparen = 1
		end,
	},
	{
		"famiu/bufdelete.nvim",
		config = function() end,
	},
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring"
		},
		lazy = false,
		config = function()
			vim.g.skip_ts_context_commentstring_module = true
			---@diagnostic disable-next-line: missing-fields
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local icons = require("utils.icons")
			local palette = require("utils.palette")
			palette.load_palette()

			require("todo-comments").setup({
				keywords = {
					FIX = {
						icon = icons.ui.Bug,
						color = palette.colors.red,
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
					},
					TODO = {
						icon = icons.ui.Check, color = palette.colors.blue, alt = { "TIP" },
					},
					HACK = {
						icon = icons.ui.Fire, color = palette.colors.orange,
					},
					WARN = {
						icon = icons.diagnostics.Warning, color = palette.colors.orange, alt = { "HINT", "HACK" },
					},
					PERF = {
						icon = icons.ui.Dashboard, color = palette.colors.purple, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
					},
					NOTE = {
						icon = icons.ui.Note, color = palette.colors.yellow, alt = { "INFO" },
					},
				},
			})
		end,
	},
	{
		"smoka7/hop.nvim",
		version = "*",
		opts = {},
		config = function()
			local hop = require("hop")
			hop.setup()

			local directions = require("hop.hint").HintDirection
			vim.keymap.set("n", "<leader>w", function()
				hop.hint_words({ direction = directions.AFTER_CURSOR, hint_offset = 1 })
			end, { remap = true, desc = "Hop word after cursor" })
			vim.keymap.set("n", "<leader>W", function()
				hop.hint_words({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
			end, { remap = true, desc = "Hop word before cursor" })
		end,
	}
}
