return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local big_screen = function()
			return vim.fn.winwidth(0) > 90
		end

		require("lualine").setup({
			extensions = { "quickfix" },
			options = {
				component_separators = "",
				section_separators = "",
				disabled_filetypes = { statusline = { "dashboard" }, winbar = { "dashboard" } },
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
				lualine_x = { { "lsp_status", cond = big_screen } },
				lualine_y = { { "progress", cond = big_screen } },
				lualine_z = { { "location", cond = big_screen } },
			},
			winbar = { lualine_y = { "filename" } },
			inactive_winbar = { lualine_y = { "filename" } },
		})
	end,
}
