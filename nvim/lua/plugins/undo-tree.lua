return {
	"mbbill/undotree",
	event = "VeryLazy",
	config = function()
		V.map("n", "<Leader>u", ":UndotreeToggle<CR>")
		vim.g.undotree_DiffAutoOpen = false
		vim.g.undotree_SetFocusWhenToggle = true
		vim.g.undotree_SplitWidth = 35
		vim.g.undotree_WindowLayout = 3
	end,
}
