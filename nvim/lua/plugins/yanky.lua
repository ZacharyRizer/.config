return {
    "gbprod/yanky.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("yanky").setup({ highlight = { timer = 100 } })
        A.map({ "n", "x" }, "y", "<Plug>(YankyYank)")
        A.map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
        A.map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
        A.map("n", "<C-j>", "<Plug>(YankyNextEntry)")
        A.map("n", "<C-k>", "<Plug>(YankyPreviousEntry)")
    end,
}
