require("options")
require("config.lazy")

-- Color scheme setup
vim.cmd.colorscheme("gruvbox")

-- Editor Keymaps (plugin specific are defined in their plugin files)
vim.keymap.set("n", "<leader>so", ":w<CR>:source ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Write file" })
vim.keymap.set("n", "<leader>qq", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>qw", ":wq<CR>", { desc = "Save and quit" })
vim.keymap.set("n", "<leader>qf", ":q!<CR>", { desc = "Force quit" })
-- vim.keymap.set("n", "<leader>pv",  ":Ex<CR>", { desc = "Filesystem explorer" })

-- Center screen after scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Split Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to split below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to split above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Clear search highlights
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

