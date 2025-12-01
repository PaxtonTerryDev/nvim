vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')


vim.pack.add({
		{ src = "https://github.com/mason-org/mason.nvim" }
})

require("mason").setup()


