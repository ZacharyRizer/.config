return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	-- dependencies = { "hrsh7th/cmp-nvim-lsp" },
	config = function()
		local lspconfig = require("lspconfig")
		-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

		A.autocmd("LspAttach", {
			group = A.augroup("Lsp_Custom_Attach", { clear = true }),
			callback = function(_, bufnr)
				local opts = { buffer = bufnr }

				A.map("n", "gr", ":Telescope lsp_references<CR>", opts)
				A.map("n", "gd", ":Telescope lsp_definitions<CR>", opts)
				A.map("n", "gi", ":Telescope lsp_implementations<CR>", opts)
				A.map("n", "gt", ":Telescope lsp_type_definitions<CR>", opts)
				A.map("n", "<Leader>a", vim.lsp.buf.code_action, opts)
				A.map("n", "<Leader>d", ":Telescope diagnostics bufnr=0<CR>", opts)
				A.map("n", "<Leader>s", ":Telescope lsp_document_symbols<CR>", opts)
				A.map("n", "<Leader>rn", vim.lsp.buf.rename, opts)
				A.map("n", "[d", vim.diagnostic.goto_prev, opts)
				A.map("n", "]d", vim.diagnostic.goto_next, opts)
				A.map("n", "K", vim.lsp.buf.hover, opts)

                local virtual_text_enabled = false
                A.map('n', '<Leader>td', function()
                    virtual_text_enabled = not virtual_text_enabled
                    vim.diagnostic.config({
                        virtual_text = virtual_text_enabled,
                    })
                end, opts)
                A.map("n", "<Leader>th", function()
                    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
                end, opts)
			end,
		})


		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

        require('lspconfig.ui.windows').default_options = { border = "rounded" }
		vim.diagnostic.config({
			float = { border = "rounded" },
			severity_sort = true,
			update_in_insert = true,
			virtual_text = false,
		})
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

		--------------- SERVER CONFIGURATIONS ---------------
		lspconfig.cssls.setup({})
		lspconfig.html.setup({})
		lspconfig.hls.setup({})
		lspconfig.jsonls.setup({})
		lspconfig.lua_ls.setup({
            settings = {
				Lua = {
					diagnostics = { globals = {"hs", "vim" } },
				},
			},
        })
		lspconfig.pyright.setup({})
		lspconfig.rust_analyzer.setup({})
		lspconfig.tsserver.setup({})
	end,
}
