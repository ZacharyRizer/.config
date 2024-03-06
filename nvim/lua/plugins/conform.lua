return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
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
				toml = { "taplo" },
				typescript = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})
	end,
}
