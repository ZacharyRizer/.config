return {
	"MagicDuck/grug-far.nvim",
	event = "VeryLazy",
	config = function()
		require("grug-far").setup({
			engines = {
				ripgrep = {
					extraArgs = "-S",
				},
			},
		})
		V.map({ "n", "v" }, "<Leader>G", '<cmd>lua require("grug-far").open()<CR>')
	end,
}
