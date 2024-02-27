vim.g.mapleader = " "
V.map("i", "<C-c>", "<ESC>")
V.map("n", "<C-c>", ":nohl<CR>")

---- terminal buffer mappings
V.map("t", "<Leader><ESC>", "<C-\\><C-n>")
V.map("t", "<C-h>", "<C-\\><C-N><C-w>h")
V.map("t", "<C-j>", "<C-\\><C-N><C-w>j")
V.map("t", "<C-k>", "<C-\\><C-N><C-w>k")
V.map("t", "<C-l>", "<C-\\><C-N><C-w>l")

---- unmapping a few keys that annoy me
V.map("n", "K", "<nop>")
V.map("n", "Q", "<nop>")
V.map("n", "<Space>", "<nop>")
V.map("n", "<BS>", "<nop>")

---- readline/emacs keys for i and c modes
V.map({ "c", "i" }, "<C-a>", "<Home>")
V.map({ "c", "i" }, "<C-b>", "<Left>")
V.map({ "c", "i" }, "<C-d>", "<Del>")
V.map({ "c", "i" }, "<C-e>", "<End>")
V.map({ "c", "i" }, "<C-f>", "<Right>")
V.map({ "c", "i" }, "<M-BS>", "<C-w>")

---- easy word replace, search/replace, and */# searching stay in place
V.map("n", "c*", "*Ncgn")
V.map("n", "*", "*N")
V.map("n", "#", "#N")
V.map("v", "*", 'y/<C-R>"<CR>N')
V.map("v", "#", 'y?<C-R>"<CR>N')
V.map("n", "<Leader>/", ":%s/")
V.map("v", "<Leader>/", ":s/")

---- more intuitive yanking
V.map("n", "Y", "y$")

---- better line connection
V.map("n", "J", "mzJ`z")

---- move/tab text easily
V.map("v", "<", "<gv")
V.map("v", ">", ">gv")
V.map("n", "<", "<<")
V.map("n", ">", ">>")
V.map("v", "J", ":m '>+1<CR>gv=gv")
V.map("v", "K", ":m '<-2<CR>gv=gv")

---- quickfix lists
vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])

V.map("n", "]q", ":cnext<CR>")
V.map("n", "[q", ":cprev<CR>")
V.map("n", "<C-q>", ":call QuickFixToggle()<CR>")
