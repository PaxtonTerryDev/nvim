vim.pack.add({
	{ src = "https://github.com/sainnhe/gruvbox-material" }
})

vim.opt.termguicolors = true
vim.opt.background = 'light'
vim.g.gruvbox_material_background = 'soft'
vim.g.gruvbox_material_foreground = 'material'

vim.cmd('colorscheme gruvbox-material')
