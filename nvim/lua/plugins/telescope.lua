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
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	event = "VeryLazy",
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local lga_actions = require("telescope-live-grep-args.actions")
		telescope.setup({
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
						["<C-f>"] = false,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<C-s>"] = actions.select_horizontal,
						["<C-t>"] = actions.toggle_selection,
						["<C-x>"] = actions.delete_buffer,
						["<c-r>"] = actions.to_fuzzy_refine,
						["<M-BS>"] = { "<c-s-w>", type = "command" },
						["<Down>"] = require("telescope.actions").cycle_history_next,
						["<Up>"] = require("telescope.actions").cycle_history_prev,
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
				live_grep_args = {
					auto_quoting = true,
					mappings = {
						i = {
							["<C-g>"] = lga_actions.quote_prompt(),
						},
					},
				},
			},
		})

		local extensions = { "fzf", "live_grep_args", "ui-select" }
		for _, ext in ipairs(extensions) do
			telescope.load_extension(ext)
		end

		V.map("n", "<Leader>c", ":Telescope commands<CR>")
		V.map("n", "<Leader>C", ":Telescope command_history<CR>")
		V.map("n", "<Leader>f", ":Telescope find_files<CR>")
		V.map("n", "<Leader>F", function()
			require("telescope.builtin").find_files({
				cwd = vim.fn.input("Find Files: ", vim.fn.getcwd(), "dir"),
			})
		end)
		V.map("n", "<leader>g", function()
			require("telescope").extensions.live_grep_args.live_grep_args()
		end)
		V.map("n", "<Leader>h", ":Telescope buffers<CR>")
		V.map("n", "<Leader>H", ":Telescope oldfiles prompt_title=History<CR>")
		V.map("n", "<Leader>m", ":Telescope help_tags prompt_title=Manual<CR>")
		V.map("n", "<Leader>M", ":Telescope keymaps<CR>")
		V.map("n", "<Leader>r", ":Telescope registers<CR>")
	end,
}
