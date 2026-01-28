import("akinsho/toggleterm.nvim")

require("toggleterm").setup {
  open_mapping = [[<c-\>]],
  close_on_exit = true,
}

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require('toggleterm.terminal').Terminal

function create_terminal(cfg)
  return Terminal:new({
    cmd = cfg.cmd or "",
    dir = cfg.dir or "git_dir",
    count = cfg.count,
    direction = cfg.direction or "horizontal",
    float_opts = {
      border = "double",
    },
    on_open = cfg.on_open or function(_) vim.cmd("startinsert!") end,
    on_close = cfg.on_close or function(_) end,
  })
end

local terminals = {
  lazygit = {
    instance = create_terminal({
      cmd = "lazygit",
      count = 4,
      direction = "float",
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, { "t", "i", "n" }, "<C-m>", "<cmd>close<CR>",
          { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<Esc>", { noremap = true, silent = true })
      end,
    }),
    keymap = "<leader>g",
  },
  claude = {
    instance = create_terminal({
      cmd = "claude",
      count = 5,
      direction = "float",
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<C-m>", "<cmd>close<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<Esc>", { noremap = true, silent = true })
      end,
    }),
    keymap = "<leader>m",
  },
}

local function toggle_instance(instance) if type(instance) == "table" and instance.toggle then instance:toggle() elseif type(instance) == "table" then for _, t in ipairs(instance) do t:toggle() end end end

for _, term in pairs(terminals) do
  vim.keymap.set("n", term.keymap, function() toggle_instance(term.instance) end, { noremap = true, silent = true })
end

function toggle_shells()
  vim.cmd("ToggleTerm direction=horizontal name=1")
  vim.cmd("ToggleTerm direction=horizontal name=2")
  vim.cmd("ToggleTerm direction=horizontal name=3")
end
vim.keymap.set("n", "<leader>t", function() toggle_shells() end, { noremap = true, silent = true })
