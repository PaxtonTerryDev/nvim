return {
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('harpoon').setup()

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
    end,
  }
}
