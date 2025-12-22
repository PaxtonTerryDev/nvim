require("colorschemes")
vim.cmd.colorscheme("pearl")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/j-morano/buffer_manager.nvim" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/tpope/vim-surround" },
})

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>so", ":w<CR>:source ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Write file" })
vim.keymap.set('n', '<leader>qq', ':q<CR>', { desc = "Quit"})
vim.keymap.set('n', '<leader>qw', ':wq<CR>', { desc = "Save and quit"})
vim.keymap.set('n', '<leader>qf', ':q!<CR>', { desc = "Force quit"})
-- Center screen after scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Split navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to split below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to split above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Commenting
vim.keymap.set("n", "gcc", "gcc", { desc = "Toggle comment line" })
vim.keymap.set("n", "gc", "gc", { desc = "Toggle comment" })
vim.keymap.set("x", "gc", "gc", { desc = "Toggle comment" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer"} )

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.opt.winborder = "rounded"

vim.o.ignorecase = true
vim.o.smartcase = true

-- Indentation settings
vim.o.tabstop = 2 -- Number of spaces a tab counts for
vim.o.shiftwidth = 2 -- Number of spaces for each indent
vim.o.softtabstop = 2 -- Number of spaces for tab in insert mode
vim.o.expandtab = true -- Use spaces instead of tabs

-- Diagnostic configuration
vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		prefix = "●",
		-- Only show errors and warnings in virtual text (less clutter)
		severity = { min = vim.diagnostic.severity.WARN },
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		wrap = true, -- Wrap long lines in float
		max_width = 80, -- Set max width for readability
	},
})

-- Auto-show diagnostic float on cursor hold (optional - uncomment to enable)
-- vim.api.nvim_create_autocmd('CursorHold', {
--   callback = function()
--     vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
--   end
-- })
-- vim.o.updatetime = 250  -- Delay before showing (in ms)

require("buffer_manager").setup({
	border_style = "rounded",
})

-- Which-key setup
require("which-key").setup({
	preset = "modern",
	win = {
		border = "rounded",
	},
})

-- Register key groups
require("which-key").add({
	{ "<leader>l", group = "LSP" },
	{ "<leader>f", group = "Find" },
	{ "<leader>p", group = "Project" },
	{ "<leader>b", group = "Buffers" },
})

require("mason").setup()
require("mason-lspconfig").setup()

-- Configure lua_ls to use system-installed version
-- vim.lsp.config('lua_ls', {
--   cmd = { '/usr/bin/lua-language-server' }
-- })

-- vim.lsp.enable({ 'ts_ls', 'lua_ls', 'rust-analyzer'})

-- LSP Keybinds (with <leader>l base)
vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "LSP: Go to declaration" })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "LSP: Show references" })
vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { desc = "LSP: Go to implementation" })
vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "LSP: Type definition" })
vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "LSP: Hover documentation" })
vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "LSP: Signature help" })
vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "LSP: Rename symbol" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP: Code action" })
vim.keymap.set("n", "<leader>lf", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "LSP: Format buffer" })
vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "LSP: Show diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Next diagnostic" })

-- Diagnostic toggle functions
local diagnostics_active = true
local function toggle_diagnostics()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.enable()
		print("Diagnostics enabled")
	else
		vim.diagnostic.disable()
		print("Diagnostics disabled")
	end
end

local function toggle_virtual_text()
	local config = vim.diagnostic.config()
	vim.diagnostic.config({ virtual_text = not config.virtual_text })
	print("Virtual text " .. (config.virtual_text and "disabled" or "enabled"))
end

local function toggle_signs()
	local config = vim.diagnostic.config()
	vim.diagnostic.config({ signs = not config.signs })
	print("Signs " .. (config.signs and "disabled" or "enabled"))
end

local function toggle_underline()
	local config = vim.diagnostic.config()
	vim.diagnostic.config({ underline = not config.underline })
	print("Underline " .. (config.underline and "disabled" or "enabled"))
end

-- Diagnostic toggle keybindings
vim.keymap.set("n", "<leader>lx", toggle_diagnostics, { desc = "LSP: Toggle all diagnostics" })
vim.keymap.set("n", "<leader>lv", toggle_virtual_text, { desc = "LSP: Toggle virtual text" })
vim.keymap.set("n", "<leader>lS", toggle_signs, { desc = "LSP: Toggle signs" })
vim.keymap.set("n", "<leader>lu", toggle_underline, { desc = "LSP: Toggle underline" })

-- Telescope setup with borders
require("telescope").setup({
	defaults = {
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })

-- Find files including hidden files
vim.keymap.set("n", "<leader>fF", function()
	builtin.find_files({ hidden = true, no_ignore = false })
end, { desc = "Find files (including hidden)" })

-- Live grep including hidden files
vim.keymap.set("n", "<leader>fG", function()
	builtin.live_grep({
		additional_args = function()
			return { "--hidden" }
		end,
	})
end, { desc = "Live grep (including hidden)" })

-- Buffer manager keymaps
vim.keymap.set("n", "<leader>bb", function()
	require("buffer_manager.ui").toggle_quick_menu()
end, { desc = "Buffer manager" })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

require("mini.completion").setup()
require("mini.pairs").setup()
require("mini.snippets").setup()

require("mini.icons").setup()
require("mini.keymap").setup()
require("mini.starter").setup()

-- Mini.files setup with custom mappings
-- require("mini.files").setup({
--   mappings = {
--     close       = 'q',
--     go_in       = 'l',
--     go_in_plus  = '<CR>',
--     go_out      = 'h',
--     go_out_plus = 'H',
--     reset       = '<BS>',
--     reveal_cwd  = '@',
--     show_help   = 'g?',
--     synchronize = '=',
--     trim_left   = '<',
--     trim_right  = '>',
--   },
-- })
-- vim.keymap.set("n", "<leader>pv", function()
-- 	require("mini.files").open()
-- end, { desc = "File explorer" })
-- vim.keymap.set("n", "<leader>pf", function()
-- 	require("mini.files").open(vim.api.nvim_buf_get_name(0))
-- end, { desc = "File explorer (current file)" })
-- vim.keymap.set("n", "<leader>pc", function()
-- 	require("mini.files").open(vim.fn.getcwd())
-- end, { desc = "File explorer (cwd)" })

-- KEYMAP SETUP

local map_multistep = require("mini.keymap").map_multistep

map_multistep("i", "<Tab>", { "pmenu_next" })
map_multistep("i", "<S-Tab>", { "pmenu_prev" })
map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
map_multistep("i", "<BS>", { "minipairs_bs" })

local map_combo = require("mini.keymap").map_combo
local mode = { "i", "c", "x", "s" }
-- Escape into normal mode with 'jk'
map_combo(mode, "jk", "<BS><BS><Esc>")
map_combo(mode, "kj", "<BS><BS><Esc>")
map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
map_combo("t", "kj", "<BS><BS><C-\\><C-n>")

-- Flash Setup

vim.pack.add({
	{ src = "https://github.com/folke/flash.nvim" },
})

require("flash").setup({
	label = {
		before = true,
		after = false,
		rainbow = {
			enabled = false,
			shade = 5,
		},
	},
})

-- Flash keymaps
vim.keymap.set({ "n", "x", "o" }, "z", function()
	require("flash").jump()
end, { desc = "Flash: Jump" })
vim.keymap.set({ "n", "x", "o" }, "Z", function()
	require("flash").treesitter()
end, { desc = "Flash: Treesitter" })
vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump({
		pattern = vim.fn.expand("<cword>"),
	})
end, { desc = "Flash: Search word under cursor" })

vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
})

require("nvim-tree").setup({
	view = {
		width = 30,
	},
	filters = {
		dotfiles = false,
	},
})

vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>pV", ":NvimTreeFindFile<CR>", { desc = "Find file in tree" })

