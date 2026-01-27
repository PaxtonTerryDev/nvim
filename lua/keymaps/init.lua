-- Mini.Keymaps
require("mini.keymap").setup()
local map_multistep = require("mini.keymap").map_multistep
local map_combo = require("mini.keymap").map_combo

map_multistep("i", "<Tab>", { "pmenu_next" })
map_multistep("i", "<S-Tab>", { "pmenu_prev" })
map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
map_multistep("i", "<BS>", { "minipairs_bs" })

local mode = { "i", "c", "x", "s" }
map_combo(mode, "jk", "<BS><BS><Esc>")
map_combo(mode, "kj", "<BS><BS><Esc>")
map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
map_combo("t", "kj", "<BS><BS><C-\\><C-n>")

-- KEYMAPS: EDITOR
vim.keymap.set("n", "<leader>so", ":w<CR>:source ~/.config/nvim/init.lua<CR>", { desc = "Shout out" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Write file" }) vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })
-- KEYMAPS: UTILITIES
vim.keymap.set("n", "<leader>p", '"+p', { desc = "[Paste] from clipboard" })
vim.keymap.set("i", "<C-p>", '<C-r>"', { desc = "[Paste] from buffer" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "[Yank] to clipboard" })
vim.keymap.set("n", "<leader>y", '"+Y', { desc = "[Yank] line to clipboard" })
vim.keymap.set("n", "<leader>Y", 'gg0vG$"+y', { desc = "[Yank] whole file" })


-- KEYMAPS: NAVIGATION
-- Center screen after scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "<S-{>", "<S-{>zz")
vim.keymap.set("n", "<S-}>", "<S-}>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Split Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to split below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to split above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })


-- KEYMAPS: LSP (additional - main LSP keymaps are in lsp/init.lua)
vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "LSP: Signature help" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Next diagnostic" })
vim.keymap.set("n", "<leader>ll", function()
  vim.lsp.stop_client(vim.lsp.get_clients())
  vim.cmd("edit")
end, { desc = "LSP: Restart" })

-- KEYMAPS: FLASH
local flash = require("flash")
vim.keymap.set("n", "z", function() flash.jump() end, { desc = "[Flash] Search" })

-- KEYMAPS: HARPOON
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'harpoon add file' })
vim.keymap.set('n', '<leader>h', ui.toggle_quick_menu, { desc = 'harpoon menu' })

vim.keymap.set('n', '<C-1>', function() ui.nav_file(1) end, { desc = 'harpoon file 1' })
vim.keymap.set('n', '<C-2>', function() ui.nav_file(2) end, { desc = 'harpoon file 2' })
vim.keymap.set('n', '<C-3>', function() ui.nav_file(3) end, { desc = 'harpoon file 3' })
vim.keymap.set('n', '<C-4>', function() ui.nav_file(4) end, { desc = 'harpoon file 4' })

vim.keymap.set('n', '<leader>hn', ui.nav_next, { desc = 'harpoon next' })
vim.keymap.set('n', '<leader>hp', ui.nav_prev, { desc = 'harpoon prev' })

-- KEYMAPS: NVIM-TREE
local tree_api = require("nvim-tree.api")
vim.keymap.set('n', '<leader>e', function() tree_api.tree.toggle() end, { desc = 'Open file tree' })
vim.keymap.set('n', '<leader>ef', ":NvimTreeFindFile<CR>", { desc = 'Open file tree at current file' })
