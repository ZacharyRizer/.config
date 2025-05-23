return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "VeryLazy",
	config = function()
		require("ibl").setup({
			scope = { enabled = false },
			exclude = {
				filetypes = { "dashboard", "haskell", "help", "python", "undotree" },
				buftypes = { "nofile", "terminal" },
			},
		})
	end,
}
