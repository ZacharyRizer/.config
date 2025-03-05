return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	config = function()
		require("gitsigns").setup({
			on_attach = function()
				local gs = package.loaded.gitsigns

				V.map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end)

				V.map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end)

				V.map("n", "gb", gs.blame_line)
				V.map("n", "<Leader>b", gs.blame)
				V.map("n", "gc", gs.preview_hunk)
				V.map("n", "<Leader>d", gs.diffthis)
			end,
		})
	end,
}
