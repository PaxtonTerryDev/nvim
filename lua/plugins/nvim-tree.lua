vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" }
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
	float = {
		enable = true,
	}
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

vim.keymap.set('n', '<leader>to', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>tO', ':NvimTreeFocus<CR>')
vim.keymap.set('n', '<leader>tc', ':NvimTreeCollapseKeepBuffers<CR>')
vim.keymap.set('n', '<leader>tC', ':NvimTreeCollapse')

