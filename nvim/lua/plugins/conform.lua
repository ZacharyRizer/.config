return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				css = { "prettierd", "prettier" },
				haskell = { "fourmolu" },
				html = { "prettierd", "prettier" },
				javascript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				lua = { "stylua" },
				markdown = { "prettierd", "prettier" },
				python = { "autopep8" },
				rust = { "rustfmt" },
				scss = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },
			},
		})
		V.map({ "n", "v" }, "<Leader><CR>", function()
			conform.format({
				lsp_fallback = true,
				timeout_ms = 1000,
			})
		end)
	end,
}
