return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				css = { "prettierd", "prettier" },
				go = { "gopls" },
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
				yaml = { "prettierd", "prettier" },
			},
			format_after_save = {
				lsp_format = "fallback",
			},
		})

		V.command("Format", function()
			conform.format({
				lsp_fallback = true,
				async = true,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
