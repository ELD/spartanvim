-- TODO: Mini.nvim configuration and plugins
return {
	"echasnovski/mini.trailspace",
	branch = "stable",
	command = { "TrimSpace" },
	init = function()
		vim.api.nvim_create_user_command("TrimSpace", function()
			require("mini.trailspace").trim()
		end, {})

		vim.api.nvim_set_keymap("n", "<leader>st", "<cmd>TrimSpace<CR>", { desc = "Trim whitespace", silent = true, noremap = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "dashboard",
			callback = function(args)
				vim.b[args.buf].minitrailspace_disable = true
				require("mini.trailspace").unhighlight()
			end,
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function()
				local trailspace = require("mini.trailspace")
				trailspace.trim()
				trailspace.trim_last_lines()
			end,
		})
	end,
	config = function(_, opts)
		require("mini.trailspace").setup(opts)
	end,
}
