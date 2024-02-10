vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.env.ZELLIJ ~= nil then
			vim.fn.system({ "zellij", "action", "switch-mode", "locked" })
		end
	end,
})

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		if vim.env.ZELLIJ ~= nil then
			vim.fn.system({ "zellij", "action", "switch-mode", "normal" })
		end
	end,
})
