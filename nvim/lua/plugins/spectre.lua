return {
	"nvim-pack/nvim-spectre",
	event = "VeryLazy",
	config = function()
		require("spectre").setup({
			is_insert_mode = true,
			is_block_ui_break = true,
		})
		V.map("n", "<C-s>", '<cmd>lua require("spectre").toggle()<CR>')
	end,
}
