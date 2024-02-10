vim.g.mapleader = " "
vim.g.maplocalleader = " "
local keymap = vim.keymap.set

-- Neovim Telescope Keybindings
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { silent = true, desc = "Telescope Find Files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { silent = true, desc = "Telescope Live Grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true, desc = "Telescope Buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { silent = true, desc = "Telescope Help Tags" })
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { silent = true, desc = "Telescope Keymaps" })

-- Nvim-Tree Mappings
keymap({"n", "i", "v"}, "<C-b>", "<cmd>NvimTreeToggle<cr>", { silent = true, desc = "Toggle NvimTree Window" })

-- Noice dismiss
keymap("n", "<leader>nd", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss Noice Messages" })
