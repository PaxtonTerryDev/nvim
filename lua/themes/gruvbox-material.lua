vim.pack.add({
	{ src = "https://github.com/sainnhe/gruvbox-material" }
})

vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_foreground = 'material'

vim.cmd('colorscheme gruvbox-material')
