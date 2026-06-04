-- Undo Tree
vim.keymap.set("n", "<Leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open({
		command = "40vnew",
		title = "Undo Tree",
	})
end, { desc = "Toggle undotree" })
