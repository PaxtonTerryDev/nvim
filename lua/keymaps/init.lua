vim.keymap.set('n', '<leader>O', 'O<Esc>O')
vim.keymap.set('n', '<leader>b', function() require("buffer_manager.ui").toggle_quick_menu() end)
