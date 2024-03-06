return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("toggleterm").setup({
			direction = "float",
			float_opts = { border = "curved" },
			open_mapping = [[<C-t>]],
			size = function(term)
				if term.direction == "horizontal" then
					return vim.o.lines * 0.3
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			shade_terminals = false,
		})
	end,
}
