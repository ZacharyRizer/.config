return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			sidebars = { "qf", "help", "undotree" },
			lualine_bold = true,
			on_highlights = function(hl, c)
				hl.DiagnosticUnnecessary = { fg = c.comment }
			end,
		})
		vim.cmd("colorscheme tokyonight")
	end,
}
