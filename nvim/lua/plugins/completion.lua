return {
	"saghen/blink.cmp",
	dependencies = {
		"windwp/nvim-autopairs",
		"windwp/nvim-ts-autotag",
	},
	version = "1.*",
	opts = {
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = { documentation = { auto_show = true } },
		fuzzy = { implementation = "prefer_rust_with_warning" },
		keymap = { preset = "enter" },
		signature = { enabled = true },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
	opts_extend = { "sources.default" },
	config = function(_, opts)
		require("blink.cmp").setup(opts)
		require("nvim-autopairs").setup()
		require("nvim-ts-autotag").setup()
	end,
}
