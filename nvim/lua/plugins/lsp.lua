return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		{ "williamboman/mason.nvim", opts = {} },
	},
	event = "VeryLazy",
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config.cssls = {}
		vim.lsp.config.gopls = {}
		vim.lsp.config.html = {}
		vim.lsp.config.jsonls = {}
		vim.lsp.config.lua_ls = {
			settings = {
				Lua = {
					diagnostics = { globals = { "hs", "vim" } },
				},
			},
		}
		vim.lsp.config.pyright = {}
		vim.lsp.config.rust_analyzer = {}
		vim.lsp.config.ts_ls = {}
		vim.lsp.config.yamlls = {}

		local servers = {
			"cssls",
			"gopls",
			"html",
			"jsonls",
			"lua_ls",
			"pyright",
			"rust_analyzer",
			"ts_ls",
			"yamlls",
		}

		vim.lsp.enable(servers)

		----> LSP-UI SETTINGS
		vim.diagnostic.config({
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			update_in_insert = true,
			virtual_text = true,
		})

		----> LSP KEYMAPS
		V.autocmd("LspAttach", {
			callback = function(event)
				local opts = { buffer = event.buf }

				V.map("n", "gr", ":Telescope lsp_references<CR>", opts)
				V.map("n", "gd", ":Telescope lsp_definitions<CR>", opts)
				V.map("n", "gi", ":Telescope lsp_implementations<CR>", opts)
				V.map("n", "gt", ":Telescope lsp_type_definitions<CR>", opts)
				V.map("n", "<Leader>la", vim.lsp.buf.code_action, opts)
				V.map("n", "<Leader>ld", ":Telescope diagnostics bufnr=0<CR>", opts)
				V.map("n", "<Leader>ls", ":Telescope lsp_document_symbols<CR>", opts)
				V.map("n", "<Leader>rn", vim.lsp.buf.rename, opts)
				V.map("n", "[d", vim.diagnostic.goto_prev, opts)
				V.map("n", "]d", vim.diagnostic.goto_next, opts)
				V.map("n", "K", vim.lsp.buf.hover, opts)

				local virtual_text_enabled = true
				V.map("n", "<Leader>td", function()
					virtual_text_enabled = not virtual_text_enabled
					vim.diagnostic.config({
						virtual_text = virtual_text_enabled,
					})
				end, opts)
				V.map("n", "<Leader>th", function()
					vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
				end, opts)
			end,
		})
	end,
}
