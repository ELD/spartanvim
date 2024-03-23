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

keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

keymap("n", "J", "mzJ`z", { desc = "Remove next line" })
keymap("n", "<C-d>", "<C-d>zz", { desc = "Move down a page and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Move up a page and center" })
keymap("n", "n", "nzzzv", { desc = "Next occurrence and center" })
keymap("n", "N", "Nzzzv", { desc = "Previous occurrence and center" })

keymap("x", "<leader>p", [["_dP]])
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without storing" })

keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy selection to system clipboard" })
keymap("n", "<leader>y", [["+Y]], { desc = "Copy line to system clipboard" })

keymap("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next item in quickfix list" })
keymap("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Previous item in quickfix list" })
keymap("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next item in location list" })
keymap("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous item in location list" })

keymap("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Find and replace current word" })
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true })
