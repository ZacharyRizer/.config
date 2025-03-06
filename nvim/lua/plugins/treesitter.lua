return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = { "folke/ts-comments.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"comment",
				"css",
				"dockerfile",
				"gitignore",
				"go",
				"graphql",
				"haskell",
				"html",
				"javascript",
				"json",
				"kotlin",
				"lua",
				"markdown",
				"python",
				"regex",
				"rust",
				"scss",
				"sql",
				"terraform",
				"toml",
				"tsx",
				"typescript",
				"vimdoc",
				"yaml",
			},
			highlight = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "+",
					node_incremental = "+",
					node_decremental = "_",
				},
			},
			indent = { enable = true },
		})
		require("ts-comments").setup({})
	end,
}
