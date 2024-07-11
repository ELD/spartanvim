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

-- autocmd("FileType", {
-- 	group = spartanvim_group,
-- 	pattern = "dashboard",
-- 	callback = function(args)
-- 		local ft = vim.bo[args.buf].filetype
-- 		if ft == "dashboard" or ft == "help" then return end
-- 		vim.b[args.buf].minitrailspace_disable = true
-- 		require("mini.trailspace").unhighlight()
-- 	end,
-- })
--
-- autocmd("BufWritePre", {
-- 	group = spartanvim_group,
-- 	pattern = "*",
-- 	callback = function()
-- 		local trailspace = require("mini.trailspace")
-- 		trailspace.trim()
-- 		trailspace.trim_last_lines()
-- 	end,
-- })
