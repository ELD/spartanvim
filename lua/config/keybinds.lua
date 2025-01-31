local keymap = vim.keymap.set

vim.g.mapleader = " "
vim.g.localmapleader = " "

-- Move lines
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up", silent = true })
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down", silent = true })

keymap("n", "J", "mzJ`z", { desc = "Remove next line" })
keymap("n", "<C-d>", "<C-d>zz", { desc = "Move down a page and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Move up a page and center" })
keymap("n", "n", "nzzzv", { desc = "Next occurrence and center" })
keymap("n", "N", "Nzzzv", { desc = "Previous occurrence and center" })

-- Yank & Paste
keymap("x", "<leader>p", "\"_dP", { desc = "Paste without buffer", noremap = true, silent = true })
keymap({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete without buffer", noremap = true, silent = true })
keymap({ "n", "v" }, "<leader>y", "\"+y", { desc = "Yank to system clipboard", noremap = true, silent = true })
keymap("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next item in quickfix list", noremap = true, silent = true })
keymap("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous item in quickfix list", noremap = true, silent = true })
keymap("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next item in location list", noremap = true, silent = true })
keymap("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous item in location list", noremap = true, silent = true })

keymap("n", "<leader>xe", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", noremap = true, silent = true })
