return {
	"L3MON4D3/LuaSnip",
	event = { "InsertEnter" },
	build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")

		A.map({ "i", "s" }, "<C-L>", function()
			ls.jump(1)
		end)
		A.map({ "i", "s" }, "<C-h>", function()
			ls.jump(-1)
		end)
    end
}
