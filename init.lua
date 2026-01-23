function import(package)
  vim.pack.add({ { src = string.format("https://github.com/%s", package) } })
end

require("options")
require("lsp")

--
-- COLORSCHEME
--
-- Clears the colorschemes background color
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*",
--   callback = function()
--     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--     vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
--   end,
-- })

require("colorschemes.melange")

--
-- DIAGNOSTICS
--

vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "●",
    -- Only show errors and warnings in virtual text (less clutter)
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    wrap = true,  -- Wrap long lines in float
    max_width = 80, -- Set max width for readability
  },
})

--
-- PLUGINS
--

-- I'm just importing mini here so I don't need to in the init modules
import("nvim-mini/mini.nvim")
-- Mini direct imports
require("mini.icons").setup()
require("mini.statusline").setup()
--Plugins
require("plugins.telescope")
require("plugins.around")
require("plugins.autopairs")
require("plugins.completion")
require("plugins.flash")
require("plugins.which-key")
require("plugins.todo-comments")
require("plugins.surround")
require("plugins.snippets")
require("plugins.harpoon")
require("plugins.buffer-tabs")
require("plugins.comment")
require("plugins.nvim-tree")
--require("plugins.files")
-- require("plugins.map")
-- require("plugins.animate")
--
-- KEYMAPS
--

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
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Write file" })
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

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


-- KEYMAPS: LSP
vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "LSP: Go to declaration" })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "LSP: Show references" })
vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { desc = "LSP: Go to implementation" })
vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "LSP: Type definition" })
vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "LSP: Hover documentation" })
vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "LSP: Signature help" })
vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "LSP: Rename symbol" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP: Code action" })
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "LSP: Format buffer" })
vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "LSP: Show diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Next diagnostic" })
vim.keymap.set("n", "<leader>ll", function()
  vim.lsp.stop_client(vim.lsp.get_clients())
  vim.cmd("edit")
end, { desc = "LSP: Restart" })

-- KEYMAPS: FLASH
local flash = require("flash")
vim.keymap.set("n", "z", function() flash.jump() end, { desc = "[Flash] Search"})

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
