require "nvchad.options"

vim.wo.relativenumber = true
vim.o.cursorlineopt = "both"

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
