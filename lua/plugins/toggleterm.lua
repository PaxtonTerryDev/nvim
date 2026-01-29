import("akinsho/toggleterm.nvim")

require("toggleterm").setup {
  open_mapping = [[<c-\>]],
  close_on_exit = true,
  direction = "float",
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

local function create_terminal(cfg)
  local opts = {
    dir = cfg.dir or "git_dir",
    count = cfg.count,
    direction = cfg.direction or "horizontal",
    float_opts = {
      border = "double",
    },
    on_open = cfg.on_open or function(_) vim.cmd("startinsert!") end,
    on_close = cfg.on_close or function(_) end,
  }
  if cfg.cmd and cfg.cmd ~= "" then
    opts.cmd = cfg.cmd
  end
  return Terminal:new(opts)
end

local CLAUDE_INSTANCE = -1

local function toggle_instance(instance)
  instance:toggle()
end

local function handle_claude(instance)
  if CLAUDE_INSTANCE == -1 then
    CLAUDE_INSTANCE = instance.count
    toggle_instance(instance)
  else
    vim.cmd(string.format("%sToggleTerm", CLAUDE_INSTANCE))
  end
end

local function floating_config(c)
  local gen_keymap = string.format("<A-%s>", c)
  local horizontal_shell_config = {
    instance = create_terminal({
      count = c,
      direction = "float",
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = term.bufnr, noremap = true, silent = true })
        vim.keymap.set("t", "<CR>", "<CR>", { buffer = term.bufnr, noremap = true, silent = true })
      end,
    }),
    keymap = gen_keymap,
    invoker = toggle_instance,
    invoker_modes = { "n", "t" }
  }
  return horizontal_shell_config
end


local function set_map(def)
  local modes = def.invoker_modes or "n"
  vim.keymap.set(modes, def.keymap, function() def.invoker(def.instance) end, { noremap = true, silent = true })
end

local terminals = {
  lazygit = {
    instance = create_terminal({
      cmd = "lazygit",
      count = 97,
      direction = "float",
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.keymap.set({ "t", "i", "n" }, "<C-m>", "<cmd>close<CR>",
          { buffer = term.bufnr, noremap = true, silent = true })
        vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = term.bufnr, noremap = true, silent = true })
        vim.keymap.set("t", "<CR>", "<CR>", { buffer = term.bufnr, noremap = true, silent = true })
      end,
    }),
    keymap = "<leader>g",
    invoker = toggle_instance
  },
  claude = {
    instance = create_terminal({
      cmd = "claude",
      size = function(term) return vim.o.columns * 0.3 end,
      count = 98,
      direction = "float",
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.keymap.set("n", "<C-m>", "<cmd>close<CR>", { buffer = term.bufnr, noremap = true, silent = true })
        vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = term.bufnr, noremap = true, silent = true })
      end,
    }),
    keymap = "<leader>m",
    invoker = handle_claude
  },
  claude_continue = {
    instance = create_terminal({
      cmd = "claude --continue",
      size = function(term) return vim.o.columns * 0.3 end,
      count = 99,
      direction = "float",
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.keymap.set("n", "<C-m>", "<cmd>close<CR>", { buffer = term.bufnr, noremap = true, silent = true })
        vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = term.bufnr, noremap = true, silent = true })
      end,
    }),
    keymap = "<leader>M",
    invoker = handle_claude
  },
}

local function create_floating_terminals(num)
  for i = 1, num do
    set_map(floating_config(i))
  end
end

local function create_custom_terminals()
  for _, value in pairs(terminals) do
    set_map(value)
  end
end


create_floating_terminals(3)
create_custom_terminals()
