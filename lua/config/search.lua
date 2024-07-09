local keymap = vim.keymap.set
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

keymap("n", "<leader>sr", ":%s/<C-r><C-w>//g<Left><Left>", { noremap = true, desc = "Search and replace at cursor" })
