local function toggle_scratch_buffer()
	local scratch_bufnr = vim.g.scratch_bufnr
	local current_bufnr = vim.api.nvim_get_current_buf()

	-- If we're currently in the scratch buffer, exit it
	if scratch_bufnr and vim.api.nvim_buf_is_valid(scratch_bufnr) and current_bufnr == scratch_bufnr then
		local alt_bufnr = vim.fn.bufnr("#")

		if alt_bufnr ~= -1 and vim.api.nvim_buf_is_valid(alt_bufnr) then
			vim.api.nvim_set_current_buf(alt_bufnr)
		elseif pcall(vim.cmd, "Dashboard") then
			-- Dashboard loaded successfully
		else
			vim.cmd("enew")
		end
		return
	end

	-- Create scratch buffer if it doesn't exist
	if not (scratch_bufnr and vim.api.nvim_buf_is_valid(scratch_bufnr)) then
		scratch_bufnr = vim.api.nvim_create_buf(false, true)
		vim.g.scratch_bufnr = scratch_bufnr

		-- Set buffer options using modern API
		vim.api.nvim_buf_set_name(scratch_bufnr, "ScratchPad")
		local buf_opts = {
			buftype = "nofile",
			bufhidden = "hide",
			swapfile = false,
			filetype = "markdown",
		}

		for opt, val in pairs(buf_opts) do
			vim.bo[scratch_bufnr][opt] = val
		end
	end

	-- Switch to scratch buffer
	vim.api.nvim_win_set_buf(0, scratch_bufnr)
end

-- Set up the keybinding
vim.keymap.set("n", "<Leader>p", toggle_scratch_buffer, { desc = "Toggle scratch buffer" })
