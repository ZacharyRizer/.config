return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	config = function()
		require("gitsigns").setup({
			on_attach = function()
				local gs = package.loaded.gitsigns

				V.map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				V.map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				V.map("n", "gb", function()
					gs.blame_line({ full = true })
				end)
			end,
		})
	end,
}
