vim.keymap.set('i', '<C-n>', '<C-n>', { desc = 'Next completion' })
vim.keymap.set('i', '<C-p>', '<C-p>', { desc = 'Previous completion' })
vim.keymap.set('i', '<C-y>', '<C-y>', { desc = 'Confirm completion' })
vim.keymap.set('i', '<CR>', function()
	return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
end, { expr = true, desc = 'Confirm completion or newline' })
