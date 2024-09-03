return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{
			"j-hui/fidget.nvim",
			opts = {
				integration = { ["nvim-tree"] = { enable = false } },
			},
		},
	},
	event = { "BufReadPre", "BufNewFile", "VeryLazy" },
	config = function()
		----> LSP-UI SETTINGS
		require("lspconfig.ui.windows").default_options = { border = "rounded" }
		vim.diagnostic.config({
			float = { border = "rounded" },
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
		local servers = {
			cssls = {},
			gopls = {},
			html = {},
			hls = {
				settings = {
					haskell = {
						formattingProvider = "fourmolu",
					},
				},
			},
			jsonls = {},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "hs", "vim" } },
					},
				},
			},
			pyright = {},
			rust_analyzer = {},
			taplo = {},
			tsserver = {},
			yamlls = {},
		}
		local ensure_installed = vim.tbl_keys(servers or {})
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		require("mason").setup({ ui = { border = "rounded" } })
		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = ensure_installed,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
