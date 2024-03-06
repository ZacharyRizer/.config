return {
	"iamcco/markdown-preview.nvim",
	event = "VeryLazy",
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
}
