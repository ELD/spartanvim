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

vim.api.nvim_create_autocmd("LspAttach", {
	desc = 'LSP actions',
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set({ "n", "x"}, "<F3>", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts)
		vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	end,
})

