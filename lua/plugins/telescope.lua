import("nvim-lua/plenary.nvim")
import("nvim-telescope/telescope.nvim")

require("telescope").setup({
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[Find] Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[Find] Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[Find] Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[Find] Help tags" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[Find] Keymaps" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[Find] Diagnostics" })

-- Find files including hidden files
vim.keymap.set("n", "<leader>fF", function()
  builtin.find_files({ hidden = true, no_ignore = false })
end, { desc = "[Find] Files (hidden)" })

-- Live grep including hidden files
vim.keymap.set("n", "<leader>fG", function()
    builtin.live_grep({
      additional_args = function()
        return { "--hidden" }
      end,
    })
  end,
  { desc = "[Find] Grep (hidden)" })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'current buffer' })


