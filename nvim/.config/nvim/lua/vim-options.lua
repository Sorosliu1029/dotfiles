vim.o.encoding = "utf-8"

-- appearance related
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.wrap = true
vim.o.linebreak = true -- line break between words

-- indent related
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- disable swap file
vim.o.swapfile = false

-- required by toggleterm
-- ref: https://github.com/akinsho/toggleterm.nvim?tab=readme-ov-file#setup
vim.o.hidden = true

vim.opt.termguicolors = true

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- :checkhealth
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
