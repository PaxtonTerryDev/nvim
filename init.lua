vim.g.mapleader = " "

vim.opt.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.opt.shiftwidth = 4
vim.o.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

require("lsp")
require("themes")
require("plugins")
require("keymaps")

