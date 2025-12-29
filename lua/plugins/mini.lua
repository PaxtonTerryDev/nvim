local function setup_keymaps()
	local map_multistep = require("mini.keymap").map_multistep
	local map_combo = require("mini.keymap").map_combo

	map_multistep("i", "<Tab>", { "pmenu_next" })
	map_multistep("i", "<S-Tab>", { "pmenu_prev" })
	map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
	map_multistep("i", "<BS>", { "minipairs_bs" })

	local mode = { "i", "c", "x", "s" }
	map_combo(mode, "jk", "<BS><BS><Esc>")
	map_combo(mode, "kj", "<BS><BS><Esc>")
	map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
	map_combo("t", "kj", "<BS><BS><C-\\><C-n>")
end

return {
	{
		"nvim-mini/mini.nvim",
		version = "*",
		init = function()
			require("mini.ai").setup()
			require("mini.pairs").setup()

			local gen_loader = require("mini.snippets").gen_loader
			local snippets_path = vim.fn.stdpath("config") .. "/snippets"
			local snippet_files = vim.fn.glob(snippets_path .. "/*.json", false, true)

			local loaders = {}
			for _, file in ipairs(snippet_files) do
				table.insert(loaders, gen_loader.from_file(file))
			end

			require("mini.snippets").setup({
				snippets = loaders,
			})
			require("mini.snippets").start_lsp_server()

			require("mini.surround").setup()
			require("mini.cursorword").setup()
			require("mini.hipatterns").setup()
			require("mini.notify").setup()
			require("mini.statusline").setup()

			require("mini.completion").setup()
			require("mini.keymap").setup()

			require("mini.diff").setup({
				view = {
					style = "sign",
					signs = { add = "▎", change = "▎", delete = "▁" },
				},
				mappings = {
					apply = "gh",
					reset = "gH",
					textobject = "gh",
					goto_first = "[H",
					goto_prev = "[h",
					goto_next = "]h",
					goto_last = "]H",
				},
			})

			require("mini.git").setup()

			vim.keymap.set("n", "<leader>gs", function()
				require("mini.git").show_at_cursor()
			end, { desc = "Git: Show info at cursor" })

			vim.keymap.set("n", "<leader>gd", function()
				require("mini.git").show_diff_source()
			end, { desc = "Git: Show diff source" })

			vim.keymap.set({ "n", "x" }, "<leader>gh", function()
				require("mini.git").show_range_history()
			end, { desc = "Git: Show range history" })

			setup_keymaps()
		end,
	},
}
