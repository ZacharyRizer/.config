-- Toggle scratch buffer functionality with fallback
local function toggle_scratch_buffer()
	-- Check if the scratch buffer already exists
	local scratch_bufnr = vim.g.scratch_bufnr

	-- Check if we're currently in the scratch buffer
	local current_bufnr = vim.api.nvim_get_current_buf()

	if scratch_bufnr and vim.api.nvim_buf_is_valid(scratch_bufnr) and current_bufnr == scratch_bufnr then
		-- We're in the scratch buffer, try to go back to the previous buffer
		local alt_bufnr = vim.fn.bufnr("#")

		if alt_bufnr ~= -1 and vim.api.nvim_buf_is_valid(alt_bufnr) then
			-- Alternate buffer exists, switch to it
			vim.api.nvim_set_current_buf(alt_bufnr)
		else
			-- No valid alternate buffer, try to go to Dashboard
			local success, _ = pcall(vim.cmd, "Dashboard")

			-- If Dashboard command fails, open a new empty buffer
			if not success then
				vim.cmd("enew")
			end
		end
	else
		-- Save current buffer number for returning later
		vim.g.pre_scratch_bufnr = current_bufnr

		if scratch_bufnr and vim.api.nvim_buf_is_valid(scratch_bufnr) then
			-- Scratch buffer exists, switch to it
			local current_win = vim.api.nvim_get_current_win()
			vim.api.nvim_win_set_buf(current_win, scratch_bufnr)
		else
			-- Create a new scratch buffer
			scratch_bufnr = vim.api.nvim_create_buf(false, true) -- Not listed, scratch buffer
			vim.g.scratch_bufnr = scratch_bufnr

			-- Set buffer options
			vim.api.nvim_buf_set_name(scratch_bufnr, "ScratchPad")
			vim.api.nvim_buf_set_option(scratch_bufnr, "buftype", "nofile")
			vim.api.nvim_buf_set_option(scratch_bufnr, "bufhidden", "hide")
			vim.api.nvim_buf_set_option(scratch_bufnr, "swapfile", false)

			-- Switch to the scratch buffer
			local current_win = vim.api.nvim_get_current_win()
			vim.api.nvim_win_set_buf(current_win, scratch_bufnr)

			-- Optional: Set filetype for syntax highlighting
			vim.api.nvim_buf_set_option(scratch_bufnr, "filetype", "markdown")
		end
	end
end

-- Set up the keybinding to toggle scratch buffer
vim.keymap.set("n", "<Leader>p", toggle_scratch_buffer, { desc = "Toggle scratch buffer" })
