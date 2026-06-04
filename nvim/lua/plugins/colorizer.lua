return {
	"catgoose/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("colorizer").setup({
			options = {
				parsers = { names = { enable = false } },
			},
		})
	end,
}
