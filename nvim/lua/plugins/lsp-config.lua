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
		V.autocmd("LspAttach", {
			group = V.augroup("kickstart-lsp-attach", { clear = true }),
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
				V.map("n", "<Leader>d", vim.diagnostic.open_float, opts)
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

		----> SERVER CONFIGURATIONS
		local lspconfig = require("lspconfig")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		lspconfig.cssls.setup({ capabilities = capabilities })
		lspconfig.html.setup({ capabilities = capabilities })
		lspconfig.hls.setup({
			capabilities = capabilities,
			settings = {
				haskell = {
					formattingProvider = "fourmolu",
				},
			},
		})
		lspconfig.jsonls.setup({ capabilities = capabilities })
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "hs", "vim" } },
				},
			},
		})
		lspconfig.pyright.setup({ capabilities = capabilities })
		lspconfig.rust_analyzer.setup({ capabilities = capabilities })
		lspconfig.taplo.setup({ capabilities = capabilities })
		lspconfig.tsserver.setup({ capabilities = capabilities })
	end,
}
