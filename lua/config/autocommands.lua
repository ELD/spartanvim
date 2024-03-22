local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local spartanvim_group = augroup("SpartaNvim", {})
local yank_group = augroup("HighlightYank", {})

autocmd("VimEnter", {
	group = spartanvim_group,
	callback = function()
		if vim.env.ZELLIJ ~= nil then
			vim.fn.system({ "zellij", "action", "switch-mode", "locked" })
		end
	end,
})

autocmd("VimLeave", {
	group = spartanvim_group,
	callback = function()
		if vim.env.ZELLIJ ~= nil then
			vim.fn.system({ "zellij", "action", "switch-mode", "normal" })
		end
	end,
})

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

autocmd({ "BufWritePre" }, {
	group = spartanvim_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

