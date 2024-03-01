return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = { "<Leader>e" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["L"] = "actions.select",
				["<C-v>"] = "actions.select_vsplit",
				["<C-s>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-r>"] = "actions.refresh",
				["-"] = "actions.parent",
				["H"] = "actions.parent",
				["~"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["_"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
			use_default_keymaps = false,
			view_options = {
				show_hidden = true,
			},
			float = {
				padding = 5,
				max_width = 120,
			},
		})
		V.map("n", "<Leader>e", function()
			require("oil").toggle_float()
		end)
	end,
}
