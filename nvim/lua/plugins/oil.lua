return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = { "<Leader>e" },
	config = function()
		local oil = require("oil")

		local function custom_open_dir()
			local node = oil.get_cursor_entry()
			if node.type == "directory" then
				oil.select()
			end
		end

		oil.setup({
			default_file_explorer = true,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-v>"] = "actions.select_vsplit",
				["<C-s>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-r>"] = "actions.refresh",
				["H"] = "actions.parent",
				["L"] = {
					callback = function()
						custom_open_dir()
					end,
					desc = "Navigate into directory",
				},
				["~"] = "actions.open_cwd",
				["`"] = "actions.cd",
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
		V.map("n", "<Leader>e", oil.toggle_float)
	end,
}
