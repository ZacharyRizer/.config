return {
	"gbprod/yanky.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("yanky").setup({ highlight = { timer = 100 } })
		V.map({ "n", "x" }, "y", "<Plug>(YankyYank)")
		V.map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
		V.map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
		V.map("n", "<C-n>", "<Plug>(YankyNextEntry)")
		V.map("n", "<C-p>", "<Plug>(YankyPreviousEntry)")
	end,
}
