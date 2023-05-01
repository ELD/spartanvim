vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

-- Redo
keymap("n", "U", "<C-r>", { silent = true, desc = "Redo" })

-- Up or down one visual line
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Next/Previous search result
keymap("n", "n", "nzzzv", { silent = true })
keymap("n", "N", "Nzzzv", { silent = true })

-- Visbility of nvim-tree
keymap("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { silent = true, desc = "Toggle NeoVim Tree" })

-- Navigate buffers
keymap("n", "<Tab>", ":bn<CR>", { silent = true, desc = "Next Tab" })
keymap("n", "<S-Tab>", ":bp<CR>", { silent = true, desc = "Previous Tab" })

-- Move lines
keymap("n", "<A-Down>", ":m .+1<CR>==", { silent = true, desc = "Move Down" })
keymap("n", "<A-Up>", ":m .-2<CR>==", { silent = true, desc = "Move Up" })

-- Split windows
keymap("n", "vs", ":vs<CR>", { silent = true, desc = "Split Vertically" })
keymap("n", "sp", ":sp<CR>", { silent = true, desc = "Split Horizontally" })

-- Better marks
keymap("n", "'", "`", { silent = true })

-- Repeat and macro
keymap("n", "`", "@a", { silent = true })
