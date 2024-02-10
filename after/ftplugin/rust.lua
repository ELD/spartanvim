local keymap = vim.keymap.set

local bufnr = vim.api.nvim_get_current_buf()

keymap("n", "<leader>ca", function() vim.cmd.RustLsp("codeAction") end,
	{ silent = true, desc = "View Rust Code Actions", buffer = bufnr })
