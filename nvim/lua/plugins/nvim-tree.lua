return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = { "<C-e>" },
	config = function()
		V.map("n", "<C-e>", ":NvimTreeToggle<CR>")

		local function custom_open_dir()
			local lib = require("nvim-tree.lib")
			local node = lib.get_node_at_cursor()

			if node.type == "directory" and not node.open then
				require("nvim-tree.api").node.open.edit()
				vim.cmd("normal! j")
			end
		end

		local function nvim_tree_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)

			V.del("n", "<C-e>", { buffer = bufnr })
			V.del("n", "<C-x>", { buffer = bufnr })
			V.del("n", "H", { buffer = bufnr })
			V.del("n", "L", { buffer = bufnr })

			V.map("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
			V.map("n", "l", custom_open_dir, opts("Open Directory"))
			V.map("n", "H", api.tree.change_root_to_parent, opts("Up a Directory"))
			V.map("n", "L", api.tree.change_root_to_node, opts("CD"))
			V.map("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
			V.map("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
			V.map("n", "gi", api.tree.toggle_gitignore_filter, opts("Toggle Ignored Files"))
			V.map("n", "g.", api.tree.toggle_hidden_filter, opts("Toggle Dot Files"))
		end

		require("nvim-tree").setup({
			actions = {
				open_file = { quit_on_open = true },
			},
			renderer = {
				indent_markers = { enable = true },
			},
			respect_buf_cwd = true,
			on_attach = nvim_tree_on_attach,
			sync_root_with_cwd = true,
			update_focused_file = { enable = true, update_root = true },
			view = { width = { min = 35 } },
		})
	end,
}
