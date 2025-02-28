return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
	},
	event = "VeryLazy",
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				entry_prefix = "  ",
				layout_config = {
					horizontal = {
						preview_cutoff = 150,
						preview_width = 0.45,
						prompt_position = "top",
					},
					width = 0.9,
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<C-x>"] = actions.delete_buffer,
						["<C-s>"] = actions.select_horizontal,
						["<C-t>"] = actions.toggle_selection,
						["<M-BS>"] = { "<c-s-w>", type = "command" },
					},
					n = {
						["<C-t>"] = actions.toggle_selection,
					},
				},
				path_display = { shorten = 5 },
				prompt_prefix = " ",
				selection_caret = " ",
				sorting_strategy = "ascending",
			},
			extensions = {
				["ui-select"] = { require("telescope.themes").get_dropdown({}) },
			},
		})
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("yank_history")

		V.map("n", "<Leader>c", ":Telescope commands<CR>")
		V.map("n", "<Leader>C", ":Telescope command_history<CR>")
		V.map("n", "<Leader>f", ":Telescope find_files<CR>")
		V.map("n", "<Leader>F", function()
			require("telescope.builtin").find_files({
				cwd = vim.fn.input("Find Files: ", vim.fn.getcwd(), "dir"),
			})
		end)
		V.map("n", "<Leader>g", ":Telescope live_grep<CR>")
		V.map("n", "<Leader>h", ":Telescope buffers<CR>")
		V.map("n", "<Leader>H", ":Telescope oldfiles prompt_title=History<CR>")
		V.map("n", "<Leader>m", ":Telescope help_tags prompt_title=Manual<CR>")
		V.map("n", "<Leader>M", ":Telescope keymaps<CR>")
		V.map("n", "<Leader>y", ":Telescope yank_history<CR>")
	end,
}
