return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	config = function()
		require("gitsigns").setup({
			on_attach = function()
				local gs = require("gitsigns")

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
				V.map("n", "gc", gs.preview_hunk)
				V.command("Blame", function()
					gs.blame()
				end, {})
				V.command("Diff", function(opts)
					if opts.args and opts.args ~= "" then
						gs.diffthis(opts.args)
					else
						gs.diffthis()
					end
				end, { nargs = "?" })
			end,
		})
	end,
}
