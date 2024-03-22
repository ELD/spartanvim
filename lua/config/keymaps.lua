vim.g.mapleader = " "
vim.g.maplocalleader = " "
local keymap = vim.keymap.set

-- Neovim Telescope Keybindings
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { silent = true, desc = "Telescope Find Files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { silent = true, desc = "Telescope Live Grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true, desc = "Telescope Buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { silent = true, desc = "Telescope Help Tags" })
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { silent = true, desc = "Telescope Keymaps" })
keymap("n", "<leader>fn", "<cmd>Telescope noice<cr>", { silent = true, desc = "Telescope Noice messages" })

-- Nvim-Tree Mappings
keymap({ "n", "i", "v" }, "<C-b>", "<cmd>NvimTreeToggle<cr>", { silent = true, desc = "Toggle NvimTree Window" })

-- Noice dismiss
keymap("n", "<leader>nd", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss Noice Messages" })

-- NOTE: Primeagen keymaps I'm deciphering...
-- INFO: These two move lines up and down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- NOTE: This removes the next line in normal mode
keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
-- keymap("n", "n", "nzzzv")
-- keymap("n", "N", "Nzzzv")

keymap("x", "<leader>p", [["_dP]])
