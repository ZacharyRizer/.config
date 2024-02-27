return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	config = function()
		----> LSP-UI SETTINGS
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		require("lspconfig.ui.windows").default_options = { border = "rounded" }
		vim.diagnostic.config({
			float = { border = "rounded" },
			severity_sort = true,
			update_in_insert = true,
			virtual_text = true,
		})
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

		----> LSP KEYMAPS
		local on_attach = function(_, bufnr)
			local opts = { buffer = bufnr }

			V.map("n", "gr", ":Telescope lsp_references<CR>", opts)
			V.map("n", "gd", ":Telescope lsp_definitions<CR>", opts)
			V.map("n", "gi", ":Telescope lsp_implementations<CR>", opts)
			V.map("n", "gt", ":Telescope lsp_type_definitions<CR>", opts)
			V.map("n", "<Leader>a", vim.lsp.buf.code_action, opts)
			V.map("n", "<Leader>d", ":Telescope diagnostics bufnr=0<CR>", opts)
			V.map("n", "<Leader>s", ":Telescope lsp_document_symbols<CR>", opts)
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
		end

		----> SERVER CONFIGURATIONS
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		lspconfig.cssls.setup({ capabilities = capabilities, on_attach = on_attach })
		lspconfig.html.setup({ capabilities = capabilities, on_attach = on_attach })
		lspconfig.hls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				haskell = {
					formattingProvider = "fourmolu",
				},
			},
		})
		lspconfig.jsonls.setup({ capabilities = capabilities, on_attach = on_attach })
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = { globals = { "hs", "vim" } },
				},
			},
		})
		lspconfig.pyright.setup({ capabilities = capabilities, on_attach = on_attach })
		lspconfig.rust_analyzer.setup({ capabilities = capabilities, on_attach = on_attach })
		lspconfig.tsserver.setup({ capabilities = capabilities, on_attach = on_attach })
	end,
}
