return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local big_screen = function()
			return vim.fn.winwidth(0) > 90
		end

		local lsp_status = function()
			local clients = vim.lsp.get_active_clients({ bufnr = 0 })
			if next(clients) == nil then
				return "No LSP Connected"
			end

			local client_names = {}
			for _, client in ipairs(clients) do
				table.insert(client_names, client.name)
			end

			return "LSP: " .. table.concat(client_names, ", ")
		end

		require("lualine").setup({
			extensions = { "quickfix" },
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = { "dashboard" } },
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = { {
					"mode",
					fmt = function(str)
						return str:sub(1, 1)
					end,
				} },
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename", "diagnostics" },
				lualine_x = { { lsp_status, cond = big_screen } },
				lualine_y = { { "progress", cond = big_screen } },
				lualine_z = { { "location", cond = big_screen } },
			},
			winbar = { lualine_y = { "filename" } },
			inactive_winbar = { lualine_y = { "filename" } },
		})
	end,
}
