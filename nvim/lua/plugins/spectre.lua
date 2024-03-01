return {
	"nvim-pack/nvim-spectre",
	keys = { "<Leader>G" },
	config = function()
		require("spectre").setup({
			is_insert_mode = true,
			is_block_ui_break = true,
		})
		V.map("n", "<leader>G", '<cmd>lua require("spectre").toggle()<CR>')
	end,
}
