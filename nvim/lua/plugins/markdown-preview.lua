return {
	"iamcco/markdown-preview.nvim",
	build = "cd app && npm install",
	ft = "markdown",
	cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
}
