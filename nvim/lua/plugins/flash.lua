return {
	"folke/flash.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
	keys = { {
		"s",
		mode = { "n", "x", "o" },
		function()
			require("flash").jump()
		end,
		desc = "Flash",
	} },
}
