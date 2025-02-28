return {
	"MagicDuck/grug-far.nvim",
	event = "VeryLazy",
	config = function()
		require("grug-far").setup({})
		V.map("n", "<Leader>G", '<cmd>lua require("grug-far").open()<CR>')
	end,
}
