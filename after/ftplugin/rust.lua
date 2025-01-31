local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set(
	"n",
	"<M-Enter>",
	function()
		vim.cmd.RustLsp("codeAction")
	end,
	{ desc = "[Rust] Code Action", silent = true, buffer = bufnr }
)
