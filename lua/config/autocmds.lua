local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local spartanvim_group = augroup("spartanvim", {})
local yank_group = augroup("highlightyank", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd("BufWritePre", {
	group = spartanvim_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})
