return {
{
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local function set_leader_keymap(cmd, func, desc)
        local cmd_str = '<leader>' .. cmd
        vim.keymap.set('n', cmd_str, func, { desc = desc })
      end

      local builtin = require 'telescope.builtin'
      set_leader_keymap('fh', builtin.help_tags, 'help tags')
      set_leader_keymap('fk', builtin.keymaps, 'keymaps')
      set_leader_keymap('ff', builtin.find_files, 'files')
      set_leader_keymap('fs', builtin.builtin, 'select telescope')
      set_leader_keymap('fw', builtin.grep_string, 'current word')
      set_leader_keymap('fg', builtin.live_grep, 'live grep')
      set_leader_keymap('fd', builtin.diagnostics, 'diagnostics')
      set_leader_keymap('fd', builtin.resume, 'resume search')
      set_leader_keymap('fr', builtin.oldfiles, 'recent files')
      set_leader_keymap('fb', builtin.buffers, 'buffers')

      vim.keymap.set('n', '<leader>fm', function()
        builtin.marks { mark_type = 'local' }
      end, { desc = 'marks (local)' })

      vim.keymap.set('n', '<leader>fM', function()
        builtin.marks { mark_type = 'global' }
      end, { desc = 'marks (global)' })

      vim.keymap.set('n', '<leader>fF', function()
        builtin.find_files { hidden = true }
      end, { desc = 'files (hidden)' })

      vim.keymap.set('n', '<leader>fG', function()
        builtin.live_grep { additional_args = { '--hidden' } }
      end, { desc = 'live grep (hidden)' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'current buffer' })

      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Grep - Open Files',
        }
      end, { desc = 'in open Files' })

      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'neovim files' })
    end,
  }
}
