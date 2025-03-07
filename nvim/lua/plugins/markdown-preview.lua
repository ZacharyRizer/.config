return {
	"iamcco/markdown-preview.nvim",
	build = "cd app && yarn install",
	event = "VeryLazy",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
}
