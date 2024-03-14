return {

	"ggandor/leap.nvim",
	dependencies = {
		"ggandor/flit.nvim",
	},
	event = "VeryLazy",
	config = function()
		require("leap").create_default_mappings()
		require("flit").setup()
	end,
}
