return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = 'horizontal',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
        },
      })

      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      local Terminal = require('toggleterm.terminal').Terminal

      local function toggle_horizontal()
        vim.cmd('ToggleTerm direction=horizontal')
      end

      local function toggle_vertical()
        vim.cmd('ToggleTerm direction=vertical')
      end

      local function toggle_float()
        vim.cmd('ToggleTerm direction=float')
      end

      local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        hidden = true,
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "i", "i", {noremap = true, silent = true})
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "a", "a", {noremap = true, silent = true})
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<esc>", {noremap = true, silent = true})
        end,
      })

      local function toggle_lazygit()
        lazygit:toggle()
      end

      vim.keymap.set('n', '<leader>tt', toggle_horizontal, { desc = 'horizontal' })
      vim.keymap.set('n', '<leader>tv', toggle_vertical, { desc = 'vertical' })
      vim.keymap.set('n', '<leader>tf', toggle_float, { desc = 'floating' })
      vim.keymap.set('n', '<leader>gg', toggle_lazygit, { desc = 'lazygit' })
    end,
  }
}
