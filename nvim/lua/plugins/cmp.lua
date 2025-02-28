return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		{ "windwp/nvim-autopairs", opts = { fast_wrap = {} } },
		{ "windwp/nvim-ts-autotag", dependencies = "nvim-treesitter/nvim-treesitter" },
	},
	event = "VeryLazy",
	config = function()
		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local ls = require("luasnip")

		require("nvim-ts-autotag").setup()

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-l>"] = cmp.mapping(function()
					if ls.expand_or_locally_jumpable() then
						ls.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if ls.locally_jumpable(-1) then
						ls.jump(-1)
					end
				end, { "i", "s" }),
			}),
			preselect = cmp.PreselectMode.None,
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "nvim_lsp", group_index = 1 },
				{ name = "luasnip", group_index = 1 },
				{ name = "path", group_index = 1 },
				{ name = "buffer", group_index = 2 },
			},
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
				scrolbar = true,
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "cmdline", keyword_length = 2 },
				{ name = "path" },
			},
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
