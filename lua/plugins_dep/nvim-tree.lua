return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require('nvim-tree').setup({
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
      })

      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'toggle explorer' })
      vim.keymap.set('n', '<leader>ef', ':NvimTreeFindFile<CR>', { desc = 'find file in explorer' })
    end,
  }
}
